import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maverick_app/widgets/appbar.dart';
import '../../controllers/transaction_controller.dart';
import 'widgets/transaction_screen_body.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key});
  final controller = Get.put(TransactionController());

  final recipientController = TextEditingController();
  final amountController = TextEditingController();
  final currencyOptions = ['Kshs', 'USD', 'GBP'];
  final selectedCurrency = 'Kshs'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Send money'),
      body: TransactionScreenBodyWidget(
        recipientController: recipientController,
        selectedCurrency: selectedCurrency,
        currencyOptions: currencyOptions,
        controller: controller,
        amountController: amountController,
      ),
    );
  }
}
