import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rxdart/rxdart.dart';
import '../models/transaction_model.dart';

class TransactionService {
  Future<String> getRecipientUid(String emailOrPhone) async {
    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailOrPhone)
        .get();

    if (userQuery.docs.isEmpty) {
      final phoneQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: emailOrPhone)
          .get();

      if (phoneQuery.docs.isEmpty) {
        throw Exception("Recipient account not found");
      }
      return phoneQuery.docs.first.id;
    }
    return userQuery.docs.first.id;
  }

  Future<void> sendMoney(TransactionModel txn) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final uid = user.uid;

    // Step 1: Find recipient account
    final recipientQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: txn.counterparty) // If counterparty is email
        .get();

    // If not found by email, try phone number
    if (recipientQuery.docs.isEmpty) {
      final phoneQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: txn.counterparty)
          .get();

      if (phoneQuery.docs.isEmpty) {
        throw Exception("Recipient account not found");
      }

      txn.receiverID = phoneQuery.docs.first.id;
    } else {
      txn.receiverID = recipientQuery.docs.first.id;
    }

    // Step 2: Prevent sending money to yourself
    if (txn.receiverID == uid) {
      throw Exception("You cannot send money to yourself");
    }

    // Step 3: References for sender and recipient balances
    final senderWalletRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('wallet')
        .doc('balance');

    final recipientWalletRef = FirebaseFirestore.instance
        .collection('users')
        .doc(txn.receiverID)
        .collection('wallet')
        .doc('balance');

    // Step 4: Create transaction doc ref
    final transactionRef = FirebaseFirestore.instance
        .collection('transactions')
        .doc();

    // Step 5: Run transaction
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // 1. Read sender's balance first
      final senderSnapshot = await transaction.get(senderWalletRef);
      final senderBalance = (senderSnapshot.data()?['amount'] ?? 0) as double;

      if (senderBalance < txn.amount) {
        throw Exception("Insufficient balance");
      }

      // 2. Read recipient's balance second
      final recipientSnapshot = await transaction.get(recipientWalletRef);
      final recipientBalance = (recipientSnapshot.data()?['amount'] ?? 0) as double;

      // 3. Perform writes after all reads
      final newSenderBalance = senderBalance - txn.amount;
      transaction.update(senderWalletRef, {'amount': newSenderBalance});

      final newRecipientBalance = recipientBalance + txn.amount;
      transaction.update(recipientWalletRef, {'amount': newRecipientBalance});

      // Save transaction
      transaction.set(transactionRef, {
        'id': txn.id,
        'senderID': uid,
        'receiverID': txn.counterparty,
        'type': txn.type,
        'amount': txn.amount,
        'currency': txn.currency,
        'counterparty': txn.counterparty,
        'date': FieldValue.serverTimestamp(),
      });
    });

    // Save local PDF receipt
    await _generateReceiptPDF(txn);
  }

  Future<void> receiveMoney(TransactionModel txn) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    final walletRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('wallet')
        .doc('balance');

    final transactionRef = FirebaseFirestore.instance
        .collection('transactions')
        .doc();

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      double currentBalance = await getWalletBalance(
        uid: uid,
        transaction: transaction,
      );

      double newBalance = currentBalance + txn.amount;
      transaction.update(walletRef, {'amount': newBalance});

      // Optionally record receive transaction
      transaction.set(transactionRef, {
        'id': txn.id,
        'senderID': user.uid,
        'type': txn.type,
        'amount': txn.amount,
        'currency': txn.currency,
        'counterparty': txn.counterparty,
        'date': FieldValue.serverTimestamp(),
      });
    });

    // Save local PDF receipt
    await _generateReceiptPDF(txn);
  }

  Future<void> _generateReceiptPDF(TransactionModel txn) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Transaction Receipt", style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text("ID: ${txn.id}"),
            pw.Text("Type: ${txn.type}"),
            pw.Text("Amount: ${txn.currency} ${txn.amount}"),
            pw.Text("Counterparty: ${txn.counterparty}"),
            pw.Text("Date: ${txn.date.toLocal()}"),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/receipt_${txn.id}.pdf");
    await file.writeAsBytes(await pdf.save());
  }

  Future<double> getWalletBalance({
    required String uid,
    Transaction? transaction,
  }) async {
    final walletRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('wallet')
        .doc('balance');

    if (transaction != null) {
      final walletSnap = await transaction.get(walletRef);
      return (walletSnap.data()?['amount'] ?? 0.0) as double;
    } else {
      final walletSnap = await walletRef.get();
      return (walletSnap.data()?['amount'] ?? 0.0) as double;
    }
  }

  // get a stream of recent transactions
  Stream<List<TransactionModel>> getRecentTransactions() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Stream.empty();

    final sentStream = FirebaseFirestore.instance
        .collection('transactions')
        .where('senderID', isEqualTo: user.uid)
        .snapshots();

    final receivedStream = FirebaseFirestore.instance
        .collection('transactions')
        .where('receiverID', isEqualTo: user.email)
        .snapshots();

    return Rx.combineLatest2<
      QuerySnapshot<Map<String, dynamic>>,
      QuerySnapshot<Map<String, dynamic>>,
      List<TransactionModel>
    >(sentStream, receivedStream, (sentSnap, receivedSnap) {
      final allDocs = [...sentSnap.docs, ...receivedSnap.docs];

      // Sort by date descending
      allDocs.sort((a, b) {
        final aDate = (a['date'] as Timestamp?)?.toDate() ?? DateTime(1970);
        final bDate = (b['date'] as Timestamp?)?.toDate() ?? DateTime(1970);
        return bDate.compareTo(aDate);
      });

      return allDocs.map((doc) {
        final data = doc.data();
        final timestamp = data['date'];
        DateTime date = DateTime.now();
        if (timestamp is Timestamp) {
          date = timestamp.toDate();
        }

        print('Data: $data');
        return TransactionModel(
          id: data['id'],
          senderID: data['senderID'],
          receiverID: data['receiverID'],
          type: data['type'],
          amount: (data['amount'] as num).toDouble(),
          currency: data['currency'],
          counterparty: data['counterparty'],
          date: date,
        );
      }).toList();
    });
  }
}
