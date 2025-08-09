import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maverick_app/core/theme/colors.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../models/transaction_model.dart';
import '../../../core/helpers/currency_formatter.dart';
import '../../../widgets/loading_widget.dart';

class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transactions = controller.recentTransactions;
      final user = FirebaseAuth.instance.currentUser;

      if (controller.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      if (transactions.isEmpty) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .2),
              Icon(BootstrapIcons.receipt_cutoff, size: 30.0),
              const SizedBox(height: 8.0),
              Text(
                'No transaction records found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final txn = transactions[index];
          return transactionRecordTile(txn, context, user);
        },
      );
    });
  }

  ListTile transactionRecordTile(TransactionModel txn, BuildContext context, User? currentUser) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage('assets/imgs/8.jpg'),
      ),
      title: Text(
        txn.counterparty,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.0),
      ),
      subtitle: transactionType(txn, context, currentUser),
      trailing: transactionDateAndAmount(txn, context, currentUser),
    );
  }

  Text transactionType(TransactionModel txn, BuildContext context, User? currentUser) {
    return Text(
      // show "Sent" for sent transactions and "Received" for received transactions
      // check if the current user is the counterparty (the one who received the cash)
      txn.counterparty == currentUser?.email ? "Received" : "Sent",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Column transactionDateAndAmount(TransactionModel txn, BuildContext context, User? currentUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          CurrencyHelper.formatTransactionAmount(
            amount: txn.amount,
            currency: txn.currency,
            isSent: txn.counterparty == currentUser?.email,
            abbreviated: true, // apply formatting & abbreviation
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: txn.counterparty == currentUser?.email
                ? kReceivedTransactionColor
                : kSentTransactionColor,
          ),
        ),
        Text(
          DateFormat.yMMMd().format(txn.date),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
