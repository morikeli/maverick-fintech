import 'package:flutter/material.dart';
import '../widgets/homescreen.dart';

import 'features/auth/forgot-password/forgot_password_screen.dart';
import 'features/auth/login/login_screen.dart';
import 'features/auth/pin/pin_screen.dart';
import 'features/auth/pin/pin_setup_screen.dart';
import 'features/auth/pin/reset_pin.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/otp/otp_screen.dart';
import 'features/auth/reset-password/reset_password_screen.dart';
import 'features/auth/signup/signup_screen.dart';
import 'features/profile/edit_profile.dart';
import 'features/profile/profile_screen.dart';
import 'features/transaction/transaction_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  TransactionScreen.routeName: (context) => TransactionScreen(),
  PinSetupScreen.routeName: (context) => PinSetupScreen(),
  ResetPinScreen.routeName: (context) => ResetPinScreen(),
  PINScreen.routeName: (context) => PINScreen(),
};
