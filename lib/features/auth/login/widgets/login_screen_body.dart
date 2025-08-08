import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../core/theme/colors.dart';
import '../../../../widgets/loading_widget.dart';
import 'login_form.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // loading widget
      if (_authController.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const SizedBox(height: 40),
            formIcon(),
            SizedBox(height: 24.0),
            formTitle(),
            const SizedBox(height: 12.0),
            formSubTitle(context),
            const SizedBox(height: 40),
            // LoginForm widget
            LoginForm(authController: _authController),
            const SizedBox(height: 32.0),
            // allow user to navigate to sign up screen
            signupScreenRedirect(context),
          ],
        ),
      );
    });
  }

  // widgets used in the login screen

  Text signupScreenRedirect(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Don't have an account?  ",
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushNamed(context, '/signup'),
          ),
        ],
      ),
    );
  }

  Text formSubTitle(BuildContext context) {
    return Text(
      'Sign in to continue',
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    );
  }

  Text formTitle() {
    return Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Center formIcon() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: kContainerLightColor,
          shape: BoxShape.rectangle,
        ),
        padding: EdgeInsets.all(16.0),
        child: Icon(
          Icons.account_balance_wallet,
          color: kIconDarkColor,
          size: 28.0,
        ),
      ),
    );
  }
}
