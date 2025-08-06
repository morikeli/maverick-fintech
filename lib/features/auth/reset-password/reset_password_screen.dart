import 'package:flutter/material.dart';

import 'components/reset_password_body.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = '/reset-password';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ResetPasswordScreenBody(),
    );
  }
}
