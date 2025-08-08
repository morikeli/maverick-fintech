import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/auth/login/login_screen.dart';
import 'homescreen.dart';
import 'loading_widget.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget.newtonCradleMedium();
        }
        // if the user is still logged in, navigate to homescreen
        if (asyncSnapshot.data != null) {
          return HomeScreen();
        }
        return LoginScreen();
      }
    );
  }
}
