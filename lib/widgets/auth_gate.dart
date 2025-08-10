import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pin_controller.dart';
import '../features/auth/login/login_screen.dart';
import '../features/auth/pin/pin_screen.dart';
import '../features/auth/pin/pin_setup_screen.dart';
import 'loading_widget.dart';

class AuthGate extends StatelessWidget {
  final PinController pinController = Get.put(PinController());
  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget.newtonCradleMedium();
        }
        // if data is null, redirect to the login screen
        if (asyncSnapshot.data == null) {
          return LoginScreen();
        }

        return FutureBuilder(
          future: pinController.checkPinStatus(),
          builder: (context, pinSnapshot) {
            if (pinSnapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget.newtonCradleMedium();
            }

            // if user has already set up their PIN, redirect them to PINScreen
            // to enter their PIN, else let them create their PIN
            if (pinController.isPinSet.value) {
              return PINScreen(); // enter PIN
            } else {
              return PinSetupScreen(); // set up PIN
            }
          },
        );
      },
    );
  }
}
