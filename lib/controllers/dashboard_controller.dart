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
    isLoading.value = true;
    fetchDashboardData();
    bindLiveTransactions();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final uid = user.uid;

      // Get user profile (first + last name) from Firestore
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final firstName = data['firstName'] ?? '';
        final lastName = data['lastName'] ?? '';
        userName.value = "$firstName $lastName".trim();
      }

      // Get wallet balance
      walletBalance.value = await _transactionService.getWalletBalance(uid: uid);
    } catch(e) {
      errorMessage.value = e.toString();
    }finally {
      isLoading.value = false;
    }
  }

  void bindLiveTransactions() {
    final stream = _transactionService.getRecentTransactions();

    stream.listen((transactions) {
      recentTransactions.assignAll(transactions);
      isLoading.value = false; // only turn off loader when first data arrives
    }, onError: (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    });
  }

  void changeCurrency(String currency) async {
    selectedCurrency.value = currency;

    // convert Kshs. to the selected currency
    if (currency == 'Kshs') {
      await refreshWalletBalance();
      walletBalance.value =  walletBalance.value;
    } else if (currency == 'USD') {
      await refreshWalletBalance();
      walletBalance.value =  walletBalance.value / 129.04;
    } else if (currency == 'GBP') {
      await refreshWalletBalance();
      walletBalance.value =  walletBalance.value / 173.54;
    }

  }

  Future<void> refreshWalletBalance() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    walletBalance.value =
        await _transactionService.getWalletBalance(uid: uid);
  }
}
