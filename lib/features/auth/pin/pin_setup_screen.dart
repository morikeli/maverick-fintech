import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/pin_controller.dart';
import 'widgets/pin_setup_form.dart';

class PinSetupScreen extends StatelessWidget {
  static String routeName = '/setup-PIN';
  final PinController pinController = Get.find<PinController>();

  PinSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setup your PIN',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PINSetupForm(controller: pinController),
    );
  }
}
