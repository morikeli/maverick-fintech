import 'package:flutter/material.dart';

import '../../../../utils/form_validation.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/reset_password_dialog.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> formErrors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          emailTextField(),
          const SizedBox(height: 24.0),
          sendResetCodeButton(context),
        ],
      ),
    );
  }

  SizedBox sendResetCodeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            ResetPasswordDialog.showResetCodeSentDialog(
              context,
              _emailController.text,
            );
          }
        },
        child: const Text(
          'Send reset code',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  CustomTextFormField emailTextField() {
    return CustomTextFormField(
      controller: _emailController,
      label: "Email",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        FormValidation.validateEmail(value);
        return null;
      },
    );
  }
}
