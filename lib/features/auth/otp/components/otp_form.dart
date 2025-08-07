import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/form_validation.dart';
import '../../login/login_screen.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> formErrors = [];
  Country? _selectedCountry;
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          countryPickerDropdown(),
          const SizedBox(height: 20.0),
          otpCodeTextField(),
          const SizedBox(height: 24.0),
          verifyAccountButton(context),
        ],
      ),
    );
  }

  SizedBox verifyAccountButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _emailController.clear();
            _countryController.clear();
            Navigator.popAndPushNamed(context, LoginScreen.routeName);
          }
        },
        child: const Text(
          'Verify Account',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  TextFormField otpCodeTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade50,
            style: BorderStyle.none,
            // width: .5
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        label: Text("1234", style: TextStyle(color: Colors.teal)),
        suffixIcon: Icon(Icons.security),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidation.validateOTPCode(value);
      },
    );
  }

  Widget countryPickerDropdown() {
    return TextFormField(
      controller: _countryController,
      readOnly: true,
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country;
              _countryController.text =
                  '${country.flagEmoji} ${country.name} (+${country.phoneCode})';
            });
          },
        );
      },
      validator: (value) {
        return FormValidation.validateSelectedCountry(value);
      },
      decoration: InputDecoration(
        hintText: "Select country",
        labelText: "Country",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
