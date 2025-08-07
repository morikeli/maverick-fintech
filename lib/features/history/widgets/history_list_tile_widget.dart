import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/colors.dart';
import '../../../models/transaction_model.dart';

class HistoryListTileWidget extends StatelessWidget {
  const HistoryListTileWidget({
    super.key,
    required this.txn,
  });

  final TransactionModel txn;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon(),
      title: titleText(),
      subtitle: subtitleText(context),
      trailing: trailingInfo(context),
    );
  }

  Column trailingInfo(BuildContext context) {
    return Column(
      children: [
        transactedAmount(context),
        transactionDate(context),
      ],
    );
  }

  Text transactionDate(BuildContext context) {
    return Text(
        DateFormat.yMMMd().format(txn.date),
        style: Theme.of(context).textTheme.labelSmall,
        overflow: TextOverflow.visible,
      );
  }

  Text transactedAmount(BuildContext context) {
    return Text(
        txn.type == "send"
            ? "-${txn.currency} ${txn.amount.toStringAsFixed(2)}" // show '-' for sent transactions
            : "+${txn.currency} ${txn.amount.toStringAsFixed(2)}", // show '+' for received transactions
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: txn.type == "send"
              ? kSentTransactionColor
              : kRecievedTransactionColor,
        ),
        overflow: TextOverflow.visible,
      );
  }

  Text subtitleText(BuildContext context) {
    return Text(
      txn.type == "send"
          ? "Sent"
          : "Received", // show "Sent" for sent transactions and "Received" for received transactions
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Text titleText() => Text(txn.counterparty);

  Icon leadingIcon() {
    return Icon(
      txn.type == 'send' ? Icons.upload : Icons.download,
      color: txn.type == 'send'
          ? kSentTransactionColor
          : kRecievedTransactionColor,
    );
  }
}
