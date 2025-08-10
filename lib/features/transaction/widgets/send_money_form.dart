import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction_controller.dart';
import '../../../core/helpers/form_validation.dart';
import '../../../core/theme/colors.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/toastification.dart';

class SendMoneyForm extends StatefulWidget {
  const SendMoneyForm({super.key, required this.transactionController});

  final TransactionController transactionController;

  @override
  State<SendMoneyForm> createState() => _SendMoneyFormState();
}

class _SendMoneyFormState extends State<SendMoneyForm> {
  final recipientController = TextEditingController();
  final amountController = TextEditingController();
  final currencyOptions = ['Kshs', 'USD', 'GBP'];
  final selectedCurrency = 'Kshs'.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              emailOrMobileNumberTextField(), // enter recipient's email or phone number
              SizedBox(height: 8.0),
              amountTextField(), // enter amount to send
              SizedBox(height: 8.0),
              // dropdown to display multiple currencies
              currencyDropdown(context),
              SizedBox(height: 20.0),
              sendMoneyButton(context),
            ],
          ),
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
              if (!_formKey.currentState!.validate()) {
                return; //stop if validation fails
              }

              final to = recipientController.text;
              final amt = double.tryParse(amountController.text) ?? 0;
              await widget.transactionController.sendMoney(
                to,
                amt,
                selectedCurrency.value,
              );

              if (widget.transactionController.statusMessage.value == null ||
                  widget.transactionController.statusMessage.value!.contains('Failed')) {
                return AppToastsWidget.dangerToastification(
                  context,
                  widget.transactionController.statusMessage.value ??
                      "Insufficient balance!",
                );
              }

              // clear controllers after successful transaction
              recipientController.clear();
              amountController.clear();

              // redirect to previous screen after successful transaction
              Get.back();
              // display a success toast
              return AppToastsWidget.successToastification(
                context,
                widget.transactionController.statusMessage.value!,
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
        if (value == null || value.trim().isEmpty) {
          return 'Please enter valid amount!';
        }

        final amount = double.tryParse(value);

        if (amount == null) {
          return 'Amount must be a number!';
        }
        if (amount <= 0) {
          return 'Amount must be greater than 0!';
        }
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
        return FormValidation.validateEmailAndPhoneNumber(recipientController.text);
      },
    );
  }
}
