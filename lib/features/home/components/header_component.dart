
import 'package:flutter/material.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../core/theme/colors.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(color: kPrimaryColor),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Balance + Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Wallet Balance',
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(
                        color: kTextLightColor,
                        fontSize: 20.0,
                      ),
                ),

                Center(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/imgs/8.jpg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${controller.selectedCurrency.value} ${controller.walletBalance.value.toStringAsFixed(2)}",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: kTextLightColor),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: controller.selectedCurrency.value,
              items: ['Kshs', 'USD', 'GBP']
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) controller.changeCurrency(val);
              },
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
