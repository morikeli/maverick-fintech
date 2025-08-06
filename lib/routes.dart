import 'package:flutter/material.dart';

import 'features/auth/forgot-password/forgot_password_screen.dart';
import 'features/auth/login/login_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/otp/otp_screen.dart';
import 'features/auth/reset-password/reset_password_screen.dart';
import 'features/auth/signup/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName:(context) => const ForgotPasswordScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),

};
