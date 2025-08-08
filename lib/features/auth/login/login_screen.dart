import 'package:flutter/material.dart';
import 'widgets/login_screen_body.dart';


class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenBody(),
    );
  }
}
