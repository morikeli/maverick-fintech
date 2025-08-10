import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pin_controller.dart';
import '../../../../core/helpers/form_validation.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/toastification.dart';
import '../pin_screen.dart';

class PINSetupForm extends StatefulWidget {
  final PinController controller;
  const PINSetupForm({super.key, required this.controller});

  @override
  State<PINSetupForm> createState() => _PINSetupFormState();
}

class _PINSetupFormState extends State<PINSetupForm> {
  final TextEditingController pinInputController = TextEditingController();
  final TextEditingController confirmPinInputController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            pinInputTextField(),
            SizedBox(height: 12.0),
            confirmPinInputTextField(),
            SizedBox(height: 12.0),
            savePinBtn(context),
          ],
        ),
      ),
    );
  }

  Row savePinBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return; // stop if validation fails
              }

              // create PIN for the user
              bool pinWasCreated = await widget.controller.savePin(
                pinInputController.text.trim(),
              );

              // if PIN was created succssfully, return a success toast
              if (pinWasCreated) {
                AppToastsWidget.successToastification(
                  context,
                  widget.controller.message.value,
                );
                Get.offAll(() => PINScreen());
              } else {
                // otherwise return error toast
                AppToastsWidget.dangerToastification(
                  context,
                  widget.controller.message.value,
                );
              }
            },
            child: Text('Save PIN'),
          ),
        ),
      ],
    );
  }

  CustomTextFormField confirmPinInputTextField() {
    return CustomTextFormField(
      controller: confirmPinInputController,
      label: 'Confirm your PIN',
      icon: BootstrapIcons.key_fill,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePIN(
          value,
          pinInputController.text.trim(),
        );
      },
    );
  }

  CustomTextFormField pinInputTextField() {
    return CustomTextFormField(
      controller: pinInputController,
      label: 'Enter your PIN',
      icon: BootstrapIcons.key,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePIN(
          value,
          pinInputController.text.trim(),
        );
      },
    );
  }
}
