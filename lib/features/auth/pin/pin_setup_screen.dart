import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/pin_controller.dart';
import 'pin_screen.dart';
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
      persistentFooterButtons: [pinSetupLink(context)],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  Text pinSetupLink(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Already have a PIN?  ",
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: 'Enter your PIN',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(
                () => PINScreen(),
                transition: Transition.leftToRightWithFade,
                duration: Duration(milliseconds: 2000),
              ),
          ),
        ],
      ),
    );
  }
}
