import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class HistoryController extends GetxController {
  final TransactionService _transactionService = TransactionService();
  
  RxList<TransactionModel> allTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> filteredTransactions = <TransactionModel>[].obs;

  RxString filterType = 'all'.obs;
  Rx<DateTime?> startDate = Rxn<DateTime>();
  Rx<DateTime?> endDate = Rxn<DateTime>();

  RxDouble totalSent = 0.0.obs;
  RxDouble totalReceived = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    bindTransactionStream();
  }

  void bindTransactionStream() {
    allTransactions.bindStream(_transactionService.getRecentTransactions());

    ever(allTransactions, (_) {
      applyFilters();
      calculateAnalytics();
    });
  }

  void applyFilters() {
    final type = filterType.value;
    final start = startDate.value;
    final end = endDate.value;

    List<TransactionModel> filtered = allTransactions;

    if (type != 'all') {
      filtered = filtered.where((txn) => txn.type == type).toList();
    }

    if (start != null) {
      filtered = filtered
          .where((txn) => txn.date.isAfter(start.subtract(Duration(days: 1))))
          .toList();
    }

    if (end != null) {
      filtered = filtered
          .where((txn) => txn.date.isBefore(end.add(Duration(days: 1))))
          .toList();
    }

    filteredTransactions.value = filtered;
  }

  void calculateAnalytics() {
    final user = FirebaseAuth.instance.currentUser;
    final userUid = user?.uid;
    final userEmail = user?.email;
    if (user == null) return;

    double sent = 0;
    double received = 0;

    for (var txn in allTransactions) {
      // if the current user is the sender, return total sent amount
      if (txn.senderID == userUid) {
        sent += txn.amount;
      }

      // if the current user is the receiver (counterparty), return total received amount
      if (txn.counterparty == userEmail) {
        received += txn.amount;
      }
    }
    totalSent.value = sent;
    totalReceived.value = received;
  }

  void updateFilters({String? type, DateTime? start, DateTime? end}) {
    if (type != null) filterType.value = type;
    if (start != null) startDate.value = start;
    if (end != null) endDate.value = end;
    applyFilters();
    calculateAnalytics();
  }
}
