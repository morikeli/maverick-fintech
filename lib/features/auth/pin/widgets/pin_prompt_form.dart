import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/pin_controller.dart';
import '../../../../core/helpers/form_validation.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/homescreen.dart';
import '../../../../widgets/toastification.dart';

class PINPromptForm extends StatefulWidget {
  final PinController controller;
  const PINPromptForm({super.key, required this.controller});

  @override
  State<PINPromptForm> createState() => _PINPromptFormState();
}

class _PINPromptFormState extends State<PINPromptForm> {
  final TextEditingController pinInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            pinTextField(),
            SizedBox(height: 12.0),
            unlockBtn(context),
          ],
        ),
      ),
    );
  }

  Row unlockBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return; // stop if validation fails
              }

              // verify user's PIN
              bool isValid = await widget.controller.verifyPin(
                pinInputController.text.trim(),
              );
              if (isValid) {
                Get.offAll(
                  () => HomeScreen(),
                  transition: Transition.zoom,
                  duration: Duration(milliseconds: 4000),
                );
              } else {
                AppToastsWidget.dangerToastification(
                  context,
                  widget.controller.message.value,
                );
              }
            },
            child: Text('Unlock'),
          ),
        ),
      ],
    );
  }

  CustomTextFormField pinTextField() {
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
