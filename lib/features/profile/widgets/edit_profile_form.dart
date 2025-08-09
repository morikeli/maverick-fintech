import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maverick_app/controllers/profile_controller.dart';

import '../../../core/helpers/form_validation.dart';
import '../../../models/user_model.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/toastification.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key, required this.controller});
  final ProfileController controller;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.isLoading.value) {
        return Center(child: LoadingWidget.newtonCradleMedium());
      }

      final user = widget.controller.user.value!;
      firstNameController.text = user.firstName!;
      lastNameController.text = user.lastName!;
      emailController.text = user.email;
      mobileNumberController.text = user.mobileNumber!;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              firstNameTextField(),
              SizedBox(height: 16.0),
              lastNameTextField(),
              SizedBox(height: 16.0),
              emailTextField(),
              SizedBox(height: 16.0),
              mobileNumberTextField(),
              SizedBox(height: 16.0),
              updateProfileButton(user),
            ],
          ),
        ),
      );
    });
  }

  Row updateProfileButton(UserModel user) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return; // stop if validation fails
              }

              // update user profile
              await widget.controller.updateUser(
                user.uid,
                firstNameController.text,
                lastNameController.text,
                emailController.text,
                mobileNumberController.text,
              );

              if (widget.controller.errorMessage.value != null && widget.controller.errorMessage.value!.contains('Exception')) {
                return AppToastsWidget.dangerToastification(
                  context,
                  widget.controller.errorMessage.value ??
                      "Couldn't update profile! Please try again later.",
                );
              }

              firstNameController.clear();
              lastNameController.clear();
              emailController.clear();
              mobileNumberController.clear();
              Get.offAndToNamed('/profile');

              // show a success notification
              return AppToastsWidget.successToastification(
                context,
                widget.controller.errorMessage.value ??
                    'Profile updated successfully!',
              );
            },
            child: const Text("Update profile"),
          ),
        ),
      ],
    );
  }

  CustomTextFormField mobileNumberTextField() {
    return CustomTextFormField(
      controller: mobileNumberController,
      label: 'Mobile number',
      icon: BootstrapIcons.phone,
      validator: (value) => FormValidation.validatePhoneNumber(value),
    );
  }

  CustomTextFormField emailTextField() {
    return CustomTextFormField(
      controller: emailController,
      label: 'Email',
      icon: BootstrapIcons.envelope,
      validator: (value) => FormValidation.validateEmail(value),
    );
  }

  CustomTextFormField lastNameTextField() {
    return CustomTextFormField(
      controller: lastNameController,
      label: 'Surname',
      icon: BootstrapIcons.person,
      validator: (value) => FormValidation.validateLastName(value),
    );
  }

  CustomTextFormField firstNameTextField() {
    return CustomTextFormField(
      controller: firstNameController,
      label: 'First name',
      icon: BootstrapIcons.person,
      validator: (value) => FormValidation.validateFirstName(value),
    );
  }
}
