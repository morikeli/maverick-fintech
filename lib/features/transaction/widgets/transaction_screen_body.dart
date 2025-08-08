import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction_controller.dart';
import '../../../core/helpers/form_validation.dart';
import '../../../core/theme/colors.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/toastification.dart';

class TransactionScreenBodyWidget extends StatefulWidget {
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
  State<TransactionScreenBodyWidget> createState() =>
      _TransactionScreenBodyWidgetState();
}

class _TransactionScreenBodyWidgetState
    extends State<TransactionScreenBodyWidget> {
  @override
  void dispose() {
    widget.recipientController.dispose();
    widget.amountController.dispose();
    widget.selectedCurrency.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            emailOrMobileNumberTextField(), // enter recipient's email or phone number
            SizedBox(height: 8.0),
            amountTextField(), // enter amount to send
            SizedBox(height: 8.0),
            currencyDropdown(
              context,
            ), // dropdown to display multiple currencies
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
            onPressed: () async {
              final to = widget.recipientController.text;
              final amt = double.tryParse(widget.amountController.text) ?? 0;
              await widget.controller.sendMoney(
                to,
                amt,
                widget.selectedCurrency.value,
              );

              if (widget.controller.statusMessage.value == null ||
                  widget.controller.statusMessage.value!.contains('Failed')) {
                return AppToastsWidget.dangerToastification(
                  context,
                  widget.controller.statusMessage.value ?? "Insufficient balance!",
                );
              }

              // clear controllers when the
              widget.recipientController.clear();
              widget.amountController.clear();

              return AppToastsWidget.successToastification(
                context,
                widget.controller.statusMessage.value!,
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
          value: widget.selectedCurrency.value,
          items: widget.currencyOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => widget.selectedCurrency.value = val!,
        ),
      ),
    );
  }

  CustomTextFormField amountTextField() {
    return CustomTextFormField(
      controller: widget.amountController,
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
      controller: widget.recipientController,
      label: "Recipient's email or mobile number",
      keyboardType: TextInputType.emailAddress,
      icon: Icons.upload,
      validator: (value) {
        return FormValidation.validatePhoneNumber(
          widget.recipientController.text,
        );
      },
    );
  }
}
