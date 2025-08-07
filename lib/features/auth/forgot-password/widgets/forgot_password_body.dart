import 'package:flutter/material.dart';
import 'forgot_password_form.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          Text(
            'Forgot Password',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 12.0),
          Text(
            'Enter your email to recieve your password reset code.',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16.0),
          ForgotPasswordForm(),
        ],
      ),
    );
  }
}
