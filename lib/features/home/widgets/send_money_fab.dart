import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colors.dart';
import '../../transaction/transaction_screen.dart';

class SendMoneyFAB extends StatelessWidget {
  const SendMoneyFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Send money',
      onPressed: () => Get.to(
        () => TransactionScreen(),
        transition: Transition.rightToLeftWithFade,
        duration: Duration(milliseconds: 1500),
      ),
      child: Icon(Icons.upload, color: kIconLightColor),
    );
  }
}
