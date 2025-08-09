import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../widgets/loading_widget.dart';
import 'signup_form.dart';

class SignupScreenBody extends StatelessWidget {
  SignupScreenBody({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_authController.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                signupScreenTitle(context),
                const SizedBox(height: 8.0),
                signupScreenSubTitle(context),
                SizedBox(height: 16.0),
                SignupForm(authController: _authController),
                SizedBox(height: 24.0),

                // if user has an account, redirect them to login screen when they tap the "Login" text
                loginScreenRedirectLink(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Text loginScreenRedirectLink(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Already have an account?  ",
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: 'Login',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushNamed(context, '/login'),
          ),
        ],
      ),
    );
  }

  Text signupScreenSubTitle(BuildContext context) {
    return Text(
      'Simplify your crypto payments with us',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.start,
    );
  }

  Text signupScreenTitle(BuildContext context) {
    return Text(
      'Create Account',
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.start,
    );
  }
}
