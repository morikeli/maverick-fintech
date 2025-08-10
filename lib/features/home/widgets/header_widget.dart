import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../core/theme/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: const BoxDecoration(color: kPrimaryColor),
          child: RefreshIndicator.adaptive(
            onRefresh: () => controller.fetchDashboardData(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Screen title + Avatar
                    screenTitleAndAvatar(context, controller.userName.value),
                    const SizedBox(height: 12.0),
                    // 2. Wallet Balance
                    walletBalance(context),
                    SizedBox(height: 4.0),
                    // 3. Dropdown to select different currencies
                    currencyTypeDropdown(context),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Row screenTitleAndAvatar(BuildContext context, String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: kTextLightColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Hello, $username',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: kTextSecondaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Center(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/imgs/5.jpg'),
          ),
        ),
      ],
    );
  }

  Widget walletBalance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Wallet Balance',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: kTextSecondaryColor,
            fontSize: 20.0,
          ),
        ),
        // SizedBox(height: 8.0),
        Text(
          "${controller.selectedCurrency.value} ${controller.walletBalance.value.toStringAsFixed(2)}/=",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: kTextLightColor,
            fontSize: 30.0,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  DropdownButton<String> currencyTypeDropdown(BuildContext context) {
    return DropdownButton<String>(
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: kTextSecondaryColor,
        fontSize: 20.0,
      ),
      value: controller.selectedCurrency.value,
      items: [
        'Kshs',
        'USD',
        'GBP',
      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) {
        if (val != null) controller.changeCurrency(val);
      },
    );
  }
}
