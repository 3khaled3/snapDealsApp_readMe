import 'package:snap_deals/core/localization/generated/l10n.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Tr.current.password_validate;
    } else if (value.length < 8) {
      return Tr.current.password_validate2;
    }
    return null;
  }

  static String? validateCategoryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a category name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePasswordConfirmation(String? value,
      {required String password}) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Name';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Address';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Age';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Number';
    } else if (value.length < 11) {
      return 'Password must be  11 characters long';
    }
    return null;
  }
}
