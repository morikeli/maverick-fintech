import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction_controller.dart';
import '../../../widgets/loading_widget.dart';
import 'send_money_form.dart';

class TransactionScreenBodyWidget extends StatelessWidget {
  TransactionScreenBodyWidget({super.key});
  final transactionController = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (transactionController.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      return SendMoneyForm(transactionController: transactionController);
    });
  }
}
