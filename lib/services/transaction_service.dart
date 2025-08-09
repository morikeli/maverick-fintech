import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
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

    // reference the document where user's wallet balance is stored
    final walletRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('wallet')
        .doc('balance');

    // create a refence for a new transaction document
    final transactionRef = FirebaseFirestore.instance
        .collection('transactions')
        .doc();

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      double currentBalance = await getWalletBalance(uid: uid, transaction: transaction);

      if (currentBalance < txn.amount) {
        throw Exception("Insufficient balance");
      }

      // Deduct and update wallet
      double newBalance = currentBalance - txn.amount;
      transaction.update(walletRef, {'amount': newBalance});

      // Save transaction
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
      double currentBalance = await getWalletBalance(uid: uid, transaction: transaction);

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

    return FirebaseFirestore.instance
        .collection('transactions')
        .where('senderID', isEqualTo: user.uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();

            final timestamp = data['date'];
            DateTime date = DateTime.now();
            if (timestamp is Timestamp) {
              date = timestamp.toDate();
            }

            return TransactionModel(
              id: data['id'],
              senderID: data['senderID'],
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
