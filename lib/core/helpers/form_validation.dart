import '../constants/errors.dart';

class FormValidation {
  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return kFirstNameNullError;
    } else if (value.length < 2) {
      return kShortFirstNameError;
    } else if (value.length > 15) {
      return kLongFirstNameError;
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return kLastNameNullError;
    } else if (value.length < 2) {
      return kShortLastNameError;
    } else if (value.length > 15) {
      return kLongLastNameError;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return kemailNullError;
    } else if (!emailValidatorRegex.hasMatch(value)) {
      return kInvalidEmailError;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return kPhoneNumberNullError;
    } else if (value.length < 10) {
      return kShortPhoneNumberError;
    } else if (value.length > 15) {
      return kLongPhoneNumberError;
    }
    return null;
  }

  static String? validatePassword(String? value, String? pwdController) {
    if (value == null || value.isEmpty) {
      return kPasswordNullError;
    } else if (value.length < 8) {
      return kShortPasswordError;
    } else if (value != pwdController) {
      return kPasswordMatchError;
    }
    return null;
  }

  static String? validateOTPCode(String? value) {
    if ((value == null || value.isEmpty)) {
      return kOTPCodeError;
    } else if (value.length < 4) {
      return kShortOTPCodeError;
    } // else if (kOTPCodeVerificationError) {
    //   setState(() {
    //     formErrors.add(kOTPCodeVerificationError);
    //   });
    // }
    return null;
  }

  static String? validatePasswordResetCode(String? value) {
    if (value == null || value.isEmpty) {
      return kOTPCodeError;
    } else if (value.length < 4) {
      return kShortOTPCodeError;
    }
    return null;
  }

  static String? validateSelectedCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a country.';
    }
    return null;
  }
}
