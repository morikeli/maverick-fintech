import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colors.dart';

class SendMoneyFAB extends StatelessWidget {
  const SendMoneyFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Send money',
      onPressed: () => Get.toNamed('/send-money'),
      child: Icon(Icons.upload, color: kIconLightColor),
    );
  }
}
