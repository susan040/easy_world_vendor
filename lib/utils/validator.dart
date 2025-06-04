import 'package:get/get.dart';

class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? checkPhoneField(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 10)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? checkPasswordField(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    } else if (fieldContent.length < 8) {
      return 'The password should be at least 8 digits';
    }

    return null;
  }

  static String? checkConfirmPassword(String? password, String? fieldContent) {
    var checkPassword = checkPasswordField(fieldContent);
    if (checkPassword != null) {
      return checkPassword;
    }

    if (password != fieldContent!) {
      return "Password does not match";
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(fieldContent.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkOptionalEmailField(String? fieldContent) {
    if (fieldContent != null &&
        fieldContent.trim().isNotEmpty &&
        !GetUtils.isEmail(fieldContent)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkPinField(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 5)) {
      return 'Invalid OTP';
    }
    return null;
  }

  // New date validation method
  static String? checkDateField(String? fieldContent) {
    if (fieldContent == null || fieldContent.trim().isEmpty) {
      return 'This field is required';
    } else {
      // Try to parse the date
      try {
        DateTime.parse(fieldContent);
      } catch (e) {
        return 'Invalid date format';
      }
    }
    return null;
  }
}
