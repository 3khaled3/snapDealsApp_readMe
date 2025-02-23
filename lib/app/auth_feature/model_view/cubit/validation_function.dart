String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePasswordConfirmation(String? value,
    {required String password}) {
  if (value == null || value.isEmpty) {
    return 'Please re-enter your password';
  } else if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Name';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Address';
  }
  return null;
}

String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Age';
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Number';
  } else if (value.length < 11) {
    return 'Password must be  11 characters long';
  }
  return null;
}
