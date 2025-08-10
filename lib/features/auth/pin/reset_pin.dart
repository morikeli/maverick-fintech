import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maverick_app/core/theme/colors.dart';

import '../../../controllers/pin_controller.dart';
import 'widgets/reset_pin_form.dart';

class ResetPinScreen extends StatelessWidget {
  static String routeName = '/reset-pin';
  ResetPinScreen({super.key});

  final PinController pinController = Get.put(PinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pinScreenAppBar(context),
      body: ResetPinForm(),
      persistentFooterButtons: [pinSetupLink(context)],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  AppBar pinScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Reset PIN', style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Text pinSetupLink(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "DO NOT ",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: kTextGreenColor,
          fontWeight: FontWeight.bold,
        ),
        children: [TextSpan(text: "share your PIN!")],
      ),
    );
  }
}
