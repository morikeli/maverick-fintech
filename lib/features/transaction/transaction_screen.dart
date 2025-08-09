import 'package:flutter/material.dart';
import 'package:maverick_app/widgets/appbar.dart';
import 'widgets/transaction_screen_body.dart';

class TransactionScreen extends StatelessWidget {
  static String routeName = '/send-money';
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, 'Send money', true),
      body: TransactionScreenBodyWidget(),
    );
  }
}
