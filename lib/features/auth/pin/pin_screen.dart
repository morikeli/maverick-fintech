import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/pin_controller.dart';
import 'pin_setup_screen.dart';
import 'widgets/pin_screen_body.dart';

class PINScreen extends StatelessWidget {
  static String routeName = '/pin-screen';
  PINScreen({super.key});

  final PinController pinController = Get.put(PinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pinScreenAppBar(context),
      body: PINScreenBody(pinController: pinController),
      persistentFooterButtons: [pinSetupLink(context)],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  AppBar pinScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Enter your PIN',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  // link to redirect user to the PIN setup screen
  Text pinSetupLink(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Don't have a PIN?  ",
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: 'Setup PIN',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(
                () => PinSetupScreen(),
                transition: Transition.downToUp,
                duration: Duration(milliseconds: 2000),
              ),
          ),
        ],
      ),
    );
  }
}
