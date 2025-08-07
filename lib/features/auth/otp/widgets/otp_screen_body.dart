import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'otp_form.dart';


class OtpScreenBody extends StatelessWidget {
  const OtpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          otpScreenTitle(context),
          otpScreenSubTitle(context),
          const SizedBox(height: 16.0),
          OtpForm(),
          const SizedBox(height: 24.0),
          resendOTPCodeLink(context),
        ],
      ),
    );
  }

  Text resendOTPCodeLink(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Didn't receive the code?  ",
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: 'Resend Code',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {},
          ),
        ],
      ),
    );
  }

  Text otpScreenSubTitle(BuildContext context) {
    return Text(
      'Enter the verification code sent to your email.',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.start,
    );
  }

  Text otpScreenTitle(BuildContext context) {
    return Text(
      'Verify Account',
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.start,
    );
  }
}
