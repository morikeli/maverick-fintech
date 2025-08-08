import 'package:flutter/material.dart';

import '../../../../widgets/custom_text_form_field.dart';
import '../../../../core/helpers/form_validation.dart';
import '../../../../widgets/homescreen.dart';

class LoginForm extends StatefulWidget {
  final AuthController authController;
  const LoginForm({super.key, required this.authController});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: formKey,
        child: Column(
          children: [
            emailTextField(),
            const SizedBox(height: 20),
            passwordTextField(),
            const SizedBox(height: 12.0),
            // "Remember Me" checkbox and "Forgot password" text
            checkBoxandForgotPassword(context),
            const SizedBox(height: 20.0),
            loginButton(context),
          ],
        ),
      );
    });
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final form = formKey.currentState;
          if (form != null && form.validate()) {
            await widget.authController.login(
              emailController.text.trim(),
              passwordController.text.trim(),
            );

            // clear text controllers if login is successful
            // otherwise, display error toast
            if (widget.authController.user.value != null) {
              form.save();
              emailController.clear();
              passwordController.clear();
              Get.offAndToNamed('/home');
            } else {
              return AppToastsWidget.dangerToastification(
                context,
                widget.authController.errorMessage.value ??
                    "Couldn't log you in. Please try again later.",
              );
            }
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Row checkBoxandForgotPassword(BuildContext context) {
    return Row(
      children: [
        Checkbox.adaptive(
            value: _rememberMe,
            activeColor: Colors.teal.shade900,
            onChanged: (value) {
              setState(() {
                _rememberMe = value!;
              });
            }),
        const Text('Remember me'),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/forgot-password'),
          child: Text(
            'Forgot password?',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  CustomTextFormField passwordTextField() {
    return CustomTextFormField(
      controller: widget.passwordController,
      label: "Password",
      icon: Icons.lock_outline,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, widget.passwordController.text);
      }
    );
  }

  CustomTextFormField emailTextField() {
    return CustomTextFormField(
      controller: widget.emailController,
      label: "Email",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }
}
