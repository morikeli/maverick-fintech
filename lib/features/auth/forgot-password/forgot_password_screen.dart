import 'package:flutter/material.dart';
import 'widgets/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ForgotPasswordBody(),
    );
  }
}
