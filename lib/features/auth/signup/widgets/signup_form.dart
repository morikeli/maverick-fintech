import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../core/helpers/form_validation.dart';
import '../../../../widgets/toastification.dart';
import '../../../../widgets/custom_text_form_field.dart';

class SignupForm extends StatefulWidget {
  final AuthController authController;
  const SignupForm({super.key, required this.authController});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // final AuthController _authController = Get.put(AuthController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // bool _hasReadTermsAndConditions = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            firstNameTextField(),
            const SizedBox(height: 20.0),
            lastNameTextField(),
            const SizedBox(height: 20.0),
            emailTextField(),
            const SizedBox(height: 20),
            mobileNumberTextField(),
            const SizedBox(height: 20),
            passwordTextField(),
            const SizedBox(height: 20),
            confirmPasswordTextField(),
            SizedBox(height: 12.0),
            termsAndConditionsCheckBox(),
            const SizedBox(height: 20.0),
            signupButton(context),
          ],
        ),
      );
    });
  }

  SizedBox signupButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final form = _formKey.currentState;
          if (form != null && form.validate()) {
            if (!widget.authController.hasReadTermsAndConditions.value) {
              // show toast notification
              return AppToastsWidget.dangerToastification(
                context,
                'Please accept the terms & conditions!',
              );
            }

            // authorize user
            await widget.authController.signup(
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _emailController.text.trim(),
              _mobileNumberController.text.trim(),
              _passwordController.text.trim(),
            );

            // clear text controllers if signup is successful
            if (widget.authController.user.value != null) {
              form.save();
              _firstNameController.clear();
              _lastNameController.clear();
              _emailController.clear();
              _mobileNumberController.clear();
              _passwordController.clear();
              Get.offAndToNamed('/login');
              return AppToastsWidget.successToastification(
                context,
                widget.authController.errorMessage.value ?? 'Account created successfully!',
              );
            } else {
              return AppToastsWidget.dangerToastification(
                context,
                widget.authController.errorMessage.value ?? 'Signup failed!',
              );
            }
          }
        },
        child: const Text(
          'Create account',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Row termsAndConditionsCheckBox() {
    return Row(
      children: [
        Checkbox.adaptive(
          value: widget.authController.hasReadTermsAndConditions.value,
          activeColor: Colors.teal.shade900,
          onChanged: (value) {
            widget.authController.hasReadTermsAndConditions.value = value ?? false;
          },
        ),
        Text(
          'Accept Terms and Conditions',
          style: TextStyle(color: Colors.teal.shade900),
        ),
      ],
    );
  }

  CustomTextFormField confirmPasswordTextField() {
    return CustomTextFormField(
      controller: _confirmPasswordController,
      label: "Confirm Password",
      icon: Icons.lock_outline,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, _passwordController.text);
      },
    );
  }

  CustomTextFormField passwordTextField() {
    return CustomTextFormField(
      controller: _passwordController,
      label: "Password",
      icon: Icons.lock_outline,
      obscureText: true,
      validator: (value) {
        return FormValidation.validatePassword(value, _passwordController.text);
      },
    );
  }

  CustomTextFormField emailTextField() {
    return CustomTextFormField(
      controller: _emailController,
      label: "Email",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateEmail(value);
      },
    );
  }

  CustomTextFormField mobileNumberTextField() {
    return CustomTextFormField(
      controller: _mobileNumberController,
      label: "Mobile Number",
      icon: BootstrapIcons.phone_flip,
      keyboardType: TextInputType.number,
      validator: (value) {
        FormValidation.validateFirstName(value);
        return null;
      },
    );
  }

  CustomTextFormField lastNameTextField() {
    return CustomTextFormField(
      controller: _lastNameController,
      label: "Last Name",
      icon: Icons.person_outline,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateLastName(value);
      },
    );
  }

  CustomTextFormField firstNameTextField() {
    return CustomTextFormField(
      controller: _firstNameController,
      label: "First Name",
      icon: Icons.person_outline,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        FormValidation.validateFirstName(value);
        return null;
      },
    );
  }
}
