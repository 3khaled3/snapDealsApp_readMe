// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Tr {
  Tr();

  static Tr? _current;

  static Tr get current {
    assert(_current != null,
        'No instance of Tr was loaded. Try to initialize the Tr delegate before accessing Tr.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Tr> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Tr();
      Tr._current = instance;

      return instance;
    });
  }

  static Tr of(BuildContext context) {
    final instance = Tr.maybeOf(context);
    assert(instance != null,
        'No instance of Tr present in the widget tree. Did you add Tr.delegate in localizationsDelegates?');
    return instance!;
  }

  static Tr? maybeOf(BuildContext context) {
    return Localizations.of<Tr>(context, Tr);
  }

  /// `en`
  String get lang {
    return Intl.message(
      'en',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `hello`
  String get hello {
    return Intl.message(
      'hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `hello world`
  String get helloWorld {
    return Intl.message(
      'hello world',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `donnne`
  String get donnne {
    return Intl.message(
      'donnne',
      name: 'donnne',
      desc: '',
      args: [],
    );
  }

  String get appName {
    return Intl.message(
      'SnapDeals',
      name: 'appName',
      desc: 'App name',
      args: [],
    );
  }

  String get loginScreenLabel {
    return Intl.message(
      'Welcome Back',
      name: 'loginScreenLabel',
      desc: 'Label for the login screen',
      args: [],
    );
  }

  String get loginLabel {
    return Intl.message(
      'Please enter your email to log in',
      name: 'loginLabel',
      desc: 'Login instruction',
      args: [],
    );
  }

  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: 'Email input label',
      args: [],
    );
  }

  String get passwordLoginLabel {
    return Intl.message(
      'Password',
      name: 'passwordLoginLabel',
      desc: 'Password input label',
      args: [],
    );
  }

  String get hintEmail {
    return Intl.message(
      'example@gmail.com',
      name: 'hintEmail',
      desc: 'Email input hint',
      args: [],
    );
  }

  String get hintPassword {
    return Intl.message(
      'Password',
      name: 'hintPassword',
      desc: 'Password input hint',
      args: [],
    );
  }

  String get forgotPasswordButton {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordButton',
      desc: 'Forgot password button label',
      args: [],
    );
  }

  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: 'Login button label',
      args: [],
    );
  }

  String get forgotPasswordScreenLabel {
    return Intl.message(
      'Reset Password',
      name: 'forgotPasswordScreenLabel',
      desc: 'Forgot password screen title',
      args: [],
    );
  }

  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your email to receive a password reset link',
      name: 'forgotPasswordDescription',
      desc: 'Forgot password screen description',
      args: [],
    );
  }

  String get sendButton {
    return Intl.message(
      'Send',
      name: 'sendButton',
      desc: 'Send button label',
      args: [],
    );
  }

  String get otpScreenLabel {
    return Intl.message(
      'Enter Verification Code',
      name: 'otpScreenLabel',
      desc: 'OTP screen title',
      args: [],
    );
  }

  String get otpDescription {
    return Intl.message(
      'Enter the code sent to your email example@gmail.com.',
      name: 'otpDescription',
      desc: 'OTP screen description',
      args: [],
    );
  }

  String get resendCodeButton {
    return Intl.message(
      'Resend Code',
      name: 'resendCodeButton',
      desc: 'Resend code button label',
      args: [],
    );
  }

  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: 'Next button label',
      args: [],
    );
  }

  String get resetPasswordDescription {
    return Intl.message(
      'Set a new password to access your account.',
      name: 'resetPasswordDescription',
      desc: 'Reset password screen description',
      args: [],
    );
  }

  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: 'New password input label',
      args: [],
    );
  }

  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmPasswordLabel',
      desc: 'Confirm new password input label',
      args: [],
    );
  }

  String get resetPasswordButton {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButton',
      desc: 'Reset password button label',
      args: [],
    );
  }

  String get orWord {
    return Intl.message(
      'Or',
      name: 'orWord',
      desc: 'Word separator for options',
      args: [],
    );
  }

  String get registerButton {
    return Intl.message(
      'Continue',
      name: 'registerButton',
      desc: 'Register/continue button label',
      args: [],
    );
  }

  String get onBoardingTitle {
    return Intl.message(
      'Welcome To',
      name: 'onBoardingTitle',
      desc: 'Onboarding title',
      args: [],
    );
  }

  String get onBoardingSubtitle1 {
    return Intl.message(
      '"Learn and Develop Your Skills Easily"',
      name: 'onBoardingSubtitle1',
      desc: 'Onboarding subtitle 1',
      args: [],
    );
  }

  String get onBoardingSubtitle2 {
    return Intl.message(
      '"Premium Educational Products"',
      name: 'onBoardingSubtitle2',
      desc: 'Onboarding subtitle 2',
      args: [],
    );
  }

  String get onBoardingSubtitle3 {
    return Intl.message(
      '"Comprehensive Educational Courses"',
      name: 'onBoardingSubtitle3',
      desc: 'Onboarding subtitle 3',
      args: [],
    );
  }

  String get onBoardingDescription1 {
    return Intl.message(
      'Discover innovative educational tools and specialized courses in one app.',
      name: 'onBoardingDescription1',
      desc: 'Onboarding description 1',
      args: [],
    );
  }

  String get onBoardingDescription2 {
    return Intl.message(
      'We offer a variety of high-quality educational tools and resources to support your learning journey—from books to modern technology tools, everything you need to elevate your study experience.',
      name: 'onBoardingDescription2',
      desc: 'Onboarding description 2',
      args: [],
    );
  }

  String get onBoardingDescription3 {
    return Intl.message(
      'Explore tailored training courses that meet your educational needs. From foundational skills to advanced topics, we provide top-quality content to help you achieve your academic and professional goals.',
      name: 'onBoardingDescription3',
      desc: 'Onboarding description 3',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Tr> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Tr> load(Locale locale) => Tr.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
