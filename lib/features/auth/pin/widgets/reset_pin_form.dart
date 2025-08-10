import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/profile_controller.dart';
import '../../../../core/helpers/form_validation.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/toastification.dart';

class ResetPinForm extends StatefulWidget {
  final ProfileController controller = Get.find<ProfileController>();
  ResetPinForm({super.key});

  @override
  State<ResetPinForm> createState() => _ResetPinFormState();
}

class _ResetPinFormState extends State<ResetPinForm> {
  final userUid = FirebaseAuth.instance.currentUser!.uid;
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
            resetPinBtn(context),
          ],
        ),
      ),
    );
  }

  Row resetPinBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return; // stop if validation fails
              }

              // create PIN for the user
              try {
                await widget.controller.updatePin(userUid, pinInputController.text.trim());
                AppToastsWidget.warningToastification(
                  context,
                  widget.controller.errorMessage.value ?? 'You have reset your PIN!'
                );
                Get.back();
              } catch (e) {
                AppToastsWidget.dangerToastification(context, e.toString());
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
