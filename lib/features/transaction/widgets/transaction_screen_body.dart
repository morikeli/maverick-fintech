import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction_controller.dart';
import '../../../core/helpers/form_validation.dart';
import '../../../core/theme/colors.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/toastification.dart';

class TransactionScreenBodyWidget extends StatelessWidget {
  const TransactionScreenBodyWidget({
    super.key,
    required this.recipientController,
    required this.selectedCurrency,
    required this.currencyOptions,
    required this.controller,
    required this.amountController,
  });

  final TextEditingController recipientController;
  final RxString selectedCurrency;
  final List<String> currencyOptions;
  final TransactionController controller;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            emailOrMobileNumberTextField(), // enter recipient's email or phone number
            SizedBox(height: 8.0),
            amountTextField(), // enter amount to send
            SizedBox(height: 8.0),
            currencyDropdown(context), // dropdown to display multiple currencies
            SizedBox(height: 20.0),
            sendMoneyButton(context),
          ],
        ),
      );
    });
  }

  Row sendMoneyButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () async {
                    final to = recipientController.text;
                    final amt = double.tryParse(amountController.text) ?? 0;
                    await controller.sendMoney(to, amt, selectedCurrency.value);

                    AppToastsWidget.successToastification(
                      context,
                      controller.statusMessage.value!,
                    );
                  },
            child: Text(
              "Send",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget currencyDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton<String>(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: kTextSecondaryColor,
            fontSize: 20.0,
          ),
          menuWidth: MediaQuery.of(context).size.width * .7,
          value: selectedCurrency.value,
          items: currencyOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => selectedCurrency.value = val!,
        ),
      ),
    );
  }

  CustomTextFormField amountTextField() {
    return CustomTextFormField(
      controller: amountController,
      label: "Amount",
      icon: BootstrapIcons.coin,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid amount!';
        }

        // TODO: Check if the user has entered 0
        // TODO: Verify if the amount entered is less than/ equal to account balance
        return null;
      },
    );
  }

  CustomTextFormField emailOrMobileNumberTextField() {
    return CustomTextFormField(
      controller: recipientController,
      label: "Recipient's email or mobile number",
      keyboardType: TextInputType.emailAddress,
      icon: Icons.upload,
      validator: (value) {
        return FormValidation.validatePhoneNumber(recipientController.text);
      },
    );
  }
}
