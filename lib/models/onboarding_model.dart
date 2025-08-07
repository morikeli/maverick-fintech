import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class OnboardingItem {
  final Icon icon;
  final String title;
  final String description;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

final onboardingItems = [
  OnboardingItem(
    icon: Icon(Icons.credit_card, color: kIconDarkColor, size: 52.0),
    title: 'Direct Pay',
    description: 'Send money across the world effortlessly.',
  ),
  OnboardingItem(
    icon: Icon(Icons.account_balance_wallet, color: kIconDarkColor, size: 52.0),
    title: 'Receive Payments',
    description: 'Receive payments hassle-free without any transaction fees.',
  ),
  OnboardingItem(
    icon: Icon(Icons.receipt_long_outlined, color: kIconDarkColor, size: 52.0),
    title: 'Pay Bills and Services',
    description: 'Pay for utility services and earn rewards!',
  ),
];
