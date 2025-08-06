import 'package:flutter/material.dart';

import 'reset_password_form.dart';

class ResetPasswordScreenBody extends StatelessWidget {
  const ResetPasswordScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          Text(
            'Reset Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Enter the code sent to your email and set a new password',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          SizedBox(height: 32.0),
          ResetPasswordForm(),
        ],
      ),
    );
  }
}
