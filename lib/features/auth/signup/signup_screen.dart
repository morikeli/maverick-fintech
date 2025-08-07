import 'package:flutter/material.dart';

import 'widgets/signup_screen_body.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SignupScreenBody(),
    );
  }
}
