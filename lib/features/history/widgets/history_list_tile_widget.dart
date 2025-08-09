import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/currency_formatter.dart';
import '../../../core/theme/colors.dart';
import '../../../models/transaction_model.dart';

class HistoryListTileWidget extends StatelessWidget {
  const HistoryListTileWidget({super.key, required this.txn, required this.currentUser});

  final TransactionModel txn;
  final User? currentUser;

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
      children: [transactedAmount(context), transactionDate(context)],
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
      overflow: TextOverflow.visible,
    );
  }

  Text subtitleText(BuildContext context) {
    return Text(
      // show "Sent" for sent transactions and "Received" for received transactions
      // check if the current user is the counterparty (the one who received the cash)
      txn.counterparty == currentUser?.email
          ? "Received"
          : "Sent",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Text titleText() => Text(txn.counterparty);

  Icon leadingIcon() {
    return Icon(
      // show upload icon for sent transactions
      // otherwise show upload icon
      txn.counterparty == currentUser?.email ? Icons.download : Icons.upload,
      color: txn.counterparty == currentUser?.email
          ? kReceivedTransactionColor
          : kSentTransactionColor
    );
  }
}
