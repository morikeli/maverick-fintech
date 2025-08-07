import 'package:flutter/material.dart';

import 'widgets/otp_screen_body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OtpScreenBody(),
    );
  }
}
