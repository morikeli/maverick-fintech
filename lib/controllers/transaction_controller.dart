import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';
import 'dashboard_controller.dart';

class TransactionController extends GetxController {
  final TransactionService _transactionService = TransactionService();
  RxnString statusMessage = RxnString();
  RxBool isLoading = false.obs;

  Future<void> sendMoney(String to, double amount, String currency) async {
    isLoading.value = true;
    try {
      // Get recipient UID before creating transaction model
      final recipientUID = await _transactionService.getRecipientUid(to);

      final txn = TransactionModel(
        id: const Uuid().v4(),
        type: 'send',
        amount: amount,
        currency: currency,
        counterparty: to,
        date: DateTime.now(),
        senderID: FirebaseAuth.instance.currentUser!.uid,
        receiverID: recipientUID,
      );
      await _transactionService.sendMoney(txn);

      // Update wallet balance instantly
      Get.find<DashboardController>().refreshWalletBalance();
      statusMessage.value = "Transaction successful! Money sent to $to.";
    } catch (e) {
      statusMessage.value = "Transaction Failed: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> simulateReceive(String from, double amount, String currency) async {
    final txn = TransactionModel(
      id: const Uuid().v4(),
      type: 'receive',
      amount: amount,
      currency: currency,
      counterparty: from,
      date: DateTime.now(),
    );
    await _transactionService.receiveMoney(txn);

    // Update wallet balance instantly
    Get.find<DashboardController>().refreshWalletBalance();
  }
}
