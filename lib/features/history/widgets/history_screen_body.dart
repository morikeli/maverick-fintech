import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/history_controller.dart';
import '../../../core/helpers/currency_formatter.dart';
import 'filter_transactions.dart';
import 'transaction_history.dart';

class HistoryScreenBodyWidget extends StatelessWidget {
  const HistoryScreenBodyWidget({
    super.key,
    required this.controller,
    required this.dateFormatter,
  });

  final HistoryController controller;
  final DateFormat dateFormatter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. Filter
            FilterTransactionsWidget(
              controller: controller,
              dateFormatter: dateFormatter,
            ),
            Divider(),
            // 2. Section for displaying total sent, and received
            basicAnalytics(context),
            Divider(),
            // 3. All transaction made
            TransactionHistoryWidget(controller: controller),
          ],
        ),
      );
    });
  }

  Padding basicAnalytics(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("Total Received"),
              Text(
                CurrencyHelper.formatTransactionAmount(
                  amount: controller.totalReceived.value,
                  currency: 'Kshs',
                  isSent: true,
                  abbreviated: false, // apply formatting & abbreviation
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text("Total Sent"),
              Text(
                CurrencyHelper.formatTransactionAmount(
                  amount: controller.totalSent.value,
                  currency: 'Kshs',
                  isSent: false,
                  abbreviated: false, // apply formatting & abbreviation
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
