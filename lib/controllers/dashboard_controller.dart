import 'package:get/get.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class DashboardController extends GetxController {
  final TransactionService _transactionService = TransactionService();

  RxBool isLoading = false.obs;
  RxDouble walletBalance = 0.0.obs;
  RxList<TransactionModel> recentTransactions = <TransactionModel>[].obs;
  RxString selectedCurrency = 'Kshs'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    bindLiveTransactions();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      walletBalance.value = await _transactionService.getWalletBalance();
    } finally {
      isLoading.value = false;
    }
  }

  void bindLiveTransactions() {
    isLoading.value = true;
    try {
      recentTransactions.bindStream(
        _transactionService.getRecentTransactions(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changeCurrency(String currency) {
    selectedCurrency.value = currency;
  }
}
