import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class ResetPasswordDialog {
  static void showResetCodeSentDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Reset Code Sent',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: kIconDarkColor, size: 42.0),
            const SizedBox(height: 16.0),
            Text(
              'A reset code has been sent to $email',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushNamed(context, '/reset-password');
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }


  static void showResetCodeFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Reset Failed',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: kIconDangerColor, size: 42.0),
            const SizedBox(height: 16.0),
            Text(
              'Invalid reset code. Please check and try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                foregroundColor: WidgetStatePropertyAll<Color>(kTextGreenColor),
              ),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
