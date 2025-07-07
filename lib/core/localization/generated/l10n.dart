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

  // skipped getter for the '// flutter pub run intl_utils:generate' key

  /// `en`
  String get lang {
    return Intl.message(
      'en',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Lora`
  String get fontFamilyLora {
    return Intl.message(
      'Lora',
      name: 'fontFamilyLora',
      desc: '',
      args: [],
    );
  }

  /// `SnapDeals`
  String get appName {
    return Intl.message(
      'SnapDeals',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get loginScreenLabel {
    return Intl.message(
      'Welcome Back',
      name: 'loginScreenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get homeTitle {
    return Intl.message(
      'Good Morning',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to log in`
  String get loginLabel {
    return Intl.message(
      'Please enter your email to log in',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLoginLabel {
    return Intl.message(
      'Password',
      name: 'passwordLoginLabel',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get hintEmail {
    return Intl.message(
      'example@gmail.com',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get hintPassword {
    return Intl.message(
      'Password',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordButton {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get registerLabel {
    return Intl.message(
      'Don\'t have an account?',
      name: 'registerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Your Number`
  String get yourNumber {
    return Intl.message(
      'Your Number',
      name: 'yourNumber',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get Number {
    return Intl.message(
      'Number',
      name: 'Number',
      desc: '',
      args: [],
    );
  }

  /// `Your Age`
  String get yourAge {
    return Intl.message(
      'Your Age',
      name: 'yourAge',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get yourAddress {
    return Intl.message(
      'Your Address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get forgotPasswordScreenLabel {
    return Intl.message(
      'Reset Password',
      name: 'forgotPasswordScreenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to receive a password reset link`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your email to receive a password reset link',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendButtonLabel {
    return Intl.message(
      'Send',
      name: 'sendButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter Verification Code`
  String get otpScreenLabel {
    return Intl.message(
      'Enter Verification Code',
      name: 'otpScreenLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your email example@gmail.com.`
  String get otpDescription {
    return Intl.message(
      'Enter the code sent to your email example@gmail.com.',
      name: 'otpDescription',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCodeButton {
    return Intl.message(
      'Resend Code',
      name: 'resendCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password to access your account.`
  String get resetPasswordDescription {
    return Intl.message(
      'Set a new password to access your account.',
      name: 'resetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButton {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orWord {
    return Intl.message(
      'Or',
      name: 'orWord',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get registerButton {
    return Intl.message(
      'Continue',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To`
  String get onBoardingTitle {
    return Intl.message(
      'Welcome To',
      name: 'onBoardingTitle',
      desc: '',
      args: [],
    );
  }

  /// `"Learn and Develop Your Skills Easily"`
  String get onBoardingSubtitle1 {
    return Intl.message(
      '"Learn and Develop Your Skills Easily"',
      name: 'onBoardingSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `"Premium Educational Products"`
  String get onBoardingSubtitle2 {
    return Intl.message(
      '"Premium Educational Products"',
      name: 'onBoardingSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `"Comprehensive Educational Courses"`
  String get onBoardingSubtitle3 {
    return Intl.message(
      '"Comprehensive Educational Courses"',
      name: 'onBoardingSubtitle3',
      desc: '',
      args: [],
    );
  }

  /// `Discover innovative educational tools and specialized courses in one app.`
  String get onBoardingDescription1 {
    return Intl.message(
      'Discover innovative educational tools and specialized courses in one app.',
      name: 'onBoardingDescription1',
      desc: '',
      args: [],
    );
  }

  /// `We offer a variety of high-quality educational tools and resources to support your learning journey—from books to modern technology tools, everything you need to elevate your study experience.`
  String get onBoardingDescription2 {
    return Intl.message(
      'We offer a variety of high-quality educational tools and resources to support your learning journey—from books to modern technology tools, everything you need to elevate your study experience.',
      name: 'onBoardingDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Explore tailored training courses that meet your educational needs. From foundational skills to advanced topics, we provide top-quality content to help you achieve your academic and professional goals.`
  String get onBoardingDescription3 {
    return Intl.message(
      'Explore tailored training courses that meet your educational needs. From foundational skills to advanced topics, we provide top-quality content to help you achieve your academic and professional goals.',
      name: 'onBoardingDescription3',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get hintSearch {
    return Intl.message(
      'What are you looking for?',
      name: 'hintSearch',
      desc: '',
      args: [],
    );
  }

  /// `Popular Course`
  String get popularCourse {
    return Intl.message(
      'Popular Course',
      name: 'popularCourse',
      desc: '',
      args: [],
    );
  }

  /// `Popular Product`
  String get popularProduct {
    return Intl.message(
      'Popular Product',
      name: 'popularProduct',
      desc: '',
      args: [],
    );
  }

  /// `Basic information`
  String get yourProfileLabel {
    return Intl.message(
      'Basic information',
      name: 'yourProfileLabel',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get contactInformation {
    return Intl.message(
      'Contact information',
      name: 'contactInformation',
      desc: '',
      args: [],
    );
  }

  /// `this is the number for buyers contacts and other notification`
  String get contactNumber {
    return Intl.message(
      'this is the number for buyers contacts and other notification',
      name: 'contactNumber',
      desc: '',
      args: [],
    );
  }

  /// `This email will be useful to keep in touch`
  String get contactEmail {
    return Intl.message(
      'This email will be useful to keep in touch',
      name: 'contactEmail',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get Version {
    return Intl.message(
      'Version',
      name: 'Version',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get Arabic {
    return Intl.message(
      'العربية',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Cancelation Policy`
  String get CancelationPolicy {
    return Intl.message(
      'Cancelation Policy',
      name: 'CancelationPolicy',
      desc: '',
      args: [],
    );
  }

  /// `*Cancellation Before Shipping:*`
  String get CancelationPolicyDiscription1 {
    return Intl.message(
      '*Cancellation Before Shipping:*',
      name: 'CancelationPolicyDiscription1',
      desc: '',
      args: [],
    );
  }

  /// `You can cancel your order at any time before it is shipped. To cancel, please contact our customer service team within 24 hours of placing your order. A full refund will be issued to your original payment method.`
  String get CancelationPolicyDiscription2 {
    return Intl.message(
      'You can cancel your order at any time before it is shipped. To cancel, please contact our customer service team within 24 hours of placing your order. A full refund will be issued to your original payment method.',
      name: 'CancelationPolicyDiscription2',
      desc: '',
      args: [],
    );
  }

  /// `*Cancellation After Shipping:*`
  String get CancelationPolicyDiscription3 {
    return Intl.message(
      '*Cancellation After Shipping:*',
      name: 'CancelationPolicyDiscription3',
      desc: '',
      args: [],
    );
  }

  /// `Once your order has been shipped, it cannot be canceled. However, you may return or exchange the product according to our return policy.`
  String get CancelationPolicyDiscription4 {
    return Intl.message(
      'Once your order has been shipped, it cannot be canceled. However, you may return or exchange the product according to our return policy.',
      name: 'CancelationPolicyDiscription4',
      desc: '',
      args: [],
    );
  }

  /// `*How to Cancel:*`
  String get CancelationPolicyDiscription5 {
    return Intl.message(
      '*How to Cancel:*',
      name: 'CancelationPolicyDiscription5',
      desc: '',
      args: [],
    );
  }

  /// `To cancel your order, please contact us at [email address or phone number], or through the app directly.`
  String get CancelationPolicyDiscription6 {
    return Intl.message(
      'To cancel your order, please contact us at [email address or phone number], or through the app directly.',
      name: 'CancelationPolicyDiscription6',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Condition`
  String get TermsAndCondition {
    return Intl.message(
      'Terms & Condition',
      name: 'TermsAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Acceptance of Terms*`
  String get TermsAndConditionTitle1 {
    return Intl.message(
      'Acceptance of Terms*',
      name: 'TermsAndConditionTitle1',
      desc: '',
      args: [],
    );
  }

  /// `By accessing or using our platform, you agree to these Terms and Conditions, as well as any applicable laws and regulations. If you do not agree to these terms, you should not use our services.`
  String get TermsAndConditionDiscription1 {
    return Intl.message(
      'By accessing or using our platform, you agree to these Terms and Conditions, as well as any applicable laws and regulations. If you do not agree to these terms, you should not use our services.',
      name: 'TermsAndConditionDiscription1',
      desc: '',
      args: [],
    );
  }

  /// `Account Registration*`
  String get TermsAndConditionTitle2 {
    return Intl.message(
      'Account Registration*',
      name: 'TermsAndConditionTitle2',
      desc: '',
      args: [],
    );
  }

  /// `To make purchases or access certain features, you may need to create an account. You are responsible for maintaining the confidentiality of your account and password, and for all activities that occur under your account.`
  String get TermsAndConditionDiscription2 {
    return Intl.message(
      'To make purchases or access certain features, you may need to create an account. You are responsible for maintaining the confidentiality of your account and password, and for all activities that occur under your account.',
      name: 'TermsAndConditionDiscription2',
      desc: '',
      args: [],
    );
  }

  /// `Products and Availability*`
  String get TermsAndConditionTitle3 {
    return Intl.message(
      'Products and Availability*',
      name: 'TermsAndConditionTitle3',
      desc: '',
      args: [],
    );
  }

  /// `We strive to provide accurate product descriptions and images. However, we cannot guarantee the availability or accuracy of all products listed on the platform. Prices and product details are subject to change without notice.`
  String get TermsAndConditionDiscription3 {
    return Intl.message(
      'We strive to provide accurate product descriptions and images. However, we cannot guarantee the availability or accuracy of all products listed on the platform. Prices and product details are subject to change without notice.',
      name: 'TermsAndConditionDiscription3',
      desc: '',
      args: [],
    );
  }

  /// `Orders and Payment*`
  String get TermsAndConditionTitle4 {
    return Intl.message(
      'Orders and Payment*',
      name: 'TermsAndConditionTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Once you place an order, it will be processed according to our order fulfillment procedures. We accept payment through various methods, including credit/debit cards and other secure payment options. You agree to pay for all orders placed under your account.`
  String get TermsAndConditionDiscription4 {
    return Intl.message(
      'Once you place an order, it will be processed according to our order fulfillment procedures. We accept payment through various methods, including credit/debit cards and other secure payment options. You agree to pay for all orders placed under your account.',
      name: 'TermsAndConditionDiscription4',
      desc: '',
      args: [],
    );
  }

  /// `Shipping and Delivery*`
  String get TermsAndConditionTitle5 {
    return Intl.message(
      'Shipping and Delivery*',
      name: 'TermsAndConditionTitle5',
      desc: '',
      args: [],
    );
  }

  /// `We aim to ship your orders as quickly as possible. Delivery times may vary depending on location, shipping method, and product availability. We are not responsible for delays caused by third-party shipping carriers or force majeure events.`
  String get TermsAndConditionDiscription5 {
    return Intl.message(
      'We aim to ship your orders as quickly as possible. Delivery times may vary depending on location, shipping method, and product availability. We are not responsible for delays caused by third-party shipping carriers or force majeure events.',
      name: 'TermsAndConditionDiscription5',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation and Returns*`
  String get TermsAndConditionTitle6 {
    return Intl.message(
      'Cancellation and Returns*',
      name: 'TermsAndConditionTitle6',
      desc: '',
      args: [],
    );
  }

  /// `Refer to our Cancellation Policy and Return Policy for information on how to cancel or return orders. You can find detailed guidelines on how to initiate a cancellation or return process on our platform.`
  String get TermsAndConditionDiscription6 {
    return Intl.message(
      'Refer to our Cancellation Policy and Return Policy for information on how to cancel or return orders. You can find detailed guidelines on how to initiate a cancellation or return process on our platform.',
      name: 'TermsAndConditionDiscription6',
      desc: '',
      args: [],
    );
  }

  /// `What are you offering?`
  String get addTitle {
    return Intl.message(
      'What are you offering?',
      name: 'addTitle',
      desc: '',
      args: [],
    );
  }

  /// `Electronic`
  String get electronics {
    return Intl.message(
      'Electronic',
      name: 'electronics',
      desc: '',
      args: [],
    );
  }

  /// `Mobiles and Tablets`
  String get mobilesAndTablets {
    return Intl.message(
      'Mobiles and Tablets',
      name: 'mobilesAndTablets',
      desc: '',
      args: [],
    );
  }

  /// `Medical tools`
  String get medicalTools {
    return Intl.message(
      'Medical tools',
      name: 'medicalTools',
      desc: '',
      args: [],
    );
  }

  /// `Drowing Tools`
  String get drawingTools {
    return Intl.message(
      'Drowing Tools',
      name: 'drawingTools',
      desc: '',
      args: [],
    );
  }

  /// `Engineer Kit`
  String get engineeringTools {
    return Intl.message(
      'Engineer Kit',
      name: 'engineeringTools',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Ad details`
  String get adDetails {
    return Intl.message(
      'Ad details',
      name: 'adDetails',
      desc: '',
      args: [],
    );
  }

  /// `Category*`
  String get category {
    return Intl.message(
      'Category*',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Add images`
  String get addImages {
    return Intl.message(
      'Add images',
      name: 'addImages',
      desc: '',
      args: [],
    );
  }

  /// `5MB maximum file size accepted in the following formats : .jpg .jpeg png .gif`
  String get addImageDis {
    return Intl.message(
      '5MB maximum file size accepted in the following formats : .jpg .jpeg png .gif',
      name: 'addImageDis',
      desc: '',
      args: [],
    );
  }

  /// `Brand *`
  String get brand {
    return Intl.message(
      'Brand *',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brandHint {
    return Intl.message(
      'Brand',
      name: 'brandHint',
      desc: '',
      args: [],
    );
  }

  /// `Condition`
  String get condition {
    return Intl.message(
      'Condition',
      name: 'condition',
      desc: '',
      args: [],
    );
  }

  /// `USED`
  String get used {
    return Intl.message(
      'USED',
      name: 'used',
      desc: '',
      args: [],
    );
  }

  /// `NEW`
  String get newWord {
    return Intl.message(
      'NEW',
      name: 'newWord',
      desc: '',
      args: [],
    );
  }

  /// `Ad title *`
  String get adTitle {
    return Intl.message(
      'Ad title *',
      name: 'adTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter title`
  String get enterTitle {
    return Intl.message(
      'Enter title',
      name: 'enterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Describtion *`
  String get describtion {
    return Intl.message(
      'Describtion *',
      name: 'describtion',
      desc: '',
      args: [],
    );
  }

  /// `Describe the item you are selling`
  String get describtionHint {
    return Intl.message(
      'Describe the item you are selling',
      name: 'describtionHint',
      desc: '',
      args: [],
    );
  }

  /// `RAM *`
  String get ramWord {
    return Intl.message(
      'RAM *',
      name: 'ramWord',
      desc: '',
      args: [],
    );
  }

  /// `Storage *`
  String get storageWord {
    return Intl.message(
      'Storage *',
      name: 'storageWord',
      desc: '',
      args: [],
    );
  }

  /// `Battery Capacity *`
  String get batteryCapacityWord {
    return Intl.message(
      'Battery Capacity *',
      name: 'batteryCapacityWord',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Price *`
  String get price {
    return Intl.message(
      'Price *',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Enter price`
  String get priceHint {
    return Intl.message(
      'Enter price',
      name: 'priceHint',
      desc: '',
      args: [],
    );
  }

  /// `Location *`
  String get location {
    return Intl.message(
      'Location *',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Choose location`
  String get locationHint {
    return Intl.message(
      'Choose location',
      name: 'locationHint',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Describtion`
  String get describtionWord {
    return Intl.message(
      'Describtion',
      name: 'describtionWord',
      desc: '',
      args: [],
    );
  }

  /// `Enter description`
  String get descriptionHint {
    return Intl.message(
      'Enter description',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Contact with the owner`
  String get ownerInformation {
    return Intl.message(
      'Contact with the owner',
      name: 'ownerInformation',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get callWord {
    return Intl.message(
      'Call',
      name: 'callWord',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get ChatWord {
    return Intl.message(
      'Chat',
      name: 'ChatWord',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get yourProfile {
    return Intl.message(
      'Your Profile',
      name: 'yourProfile',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Password  Manager`
  String get passwordManager {
    return Intl.message(
      'Password  Manager',
      name: 'passwordManager',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_change_success {
    return Intl.message(
      'Password changed successfully',
      name: 'password_change_success',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logOutHint {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logOutHint',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelWord {
    return Intl.message(
      'Cancel',
      name: 'cancelWord',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Logout`
  String get logOutButtonLabel {
    return Intl.message(
      'Yes, Logout',
      name: 'logOutButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password correctly`
  String get currentPassword_error {
    return Intl.message(
      'Please enter your password correctly',
      name: 'currentPassword_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get password_validate {
    return Intl.message(
      'Please enter your new password',
      name: 'password_validate',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_validate2 {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_validate2',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favoriteView {
    return Intl.message(
      'Favorite',
      name: 'favoriteView',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Less`
  String get less {
    return Intl.message(
      'Less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log in?`
  String get login_prompt {
    return Intl.message(
      'Do you want to log in?',
      name: 'login_prompt',
      desc: '',
      args: [],
    );
  }

  /// `You must log in to continue accessing all services.`
  String get login_message {
    return Intl.message(
      'You must log in to continue accessing all services.',
      name: 'login_message',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continue_as_guest {
    return Intl.message(
      'Continue as Guest',
      name: 'continue_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `please inter a valid email and password`
  String get loginError {
    return Intl.message(
      'please inter a valid email and password',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get loginSuccess {
    return Intl.message(
      'Login Success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `logout success`
  String get logout_success {
    return Intl.message(
      'logout success',
      name: 'logout_success',
      desc: '',
      args: [],
    );
  }

  /// `logout error`
  String get logout_error {
    return Intl.message(
      'logout error',
      name: 'logout_error',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get add_category {
    return Intl.message(
      'Add Category',
      name: 'add_category',
      desc: '',
      args: [],
    );
  }

  /// `Add Category Name`
  String get add_category_hint {
    return Intl.message(
      'Add Category Name',
      name: 'add_category_hint',
      desc: '',
      args: [],
    );
  }

  /// `Category added successfully`
  String get add_category_success {
    return Intl.message(
      'Category added successfully',
      name: 'add_category_success',
      desc: '',
      args: [],
    );
  }

  /// `Error adding category`
  String get add_category_error {
    return Intl.message(
      'Error adding category',
      name: 'add_category_error',
      desc: '',
      args: [],
    );
  }

  /// `Delete Category`
  String get delete_category {
    return Intl.message(
      'Delete Category',
      name: 'delete_category',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this category?`
  String get delete_category_hint {
    return Intl.message(
      'Are you sure you want to delete this category?',
      name: 'delete_category_hint',
      desc: '',
      args: [],
    );
  }

  /// `Category deleted successfully`
  String get delete_category_success {
    return Intl.message(
      'Category deleted successfully',
      name: 'delete_category_success',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting category`
  String get delete_category_error {
    return Intl.message(
      'Error deleting category',
      name: 'delete_category_error',
      desc: '',
      args: [],
    );
  }

  /// `Update Category`
  String get update_category {
    return Intl.message(
      'Update Category',
      name: 'update_category',
      desc: '',
      args: [],
    );
  }

  /// `Update Category Name`
  String get update_category_hint {
    return Intl.message(
      'Update Category Name',
      name: 'update_category_hint',
      desc: '',
      args: [],
    );
  }

  /// `Category updated successfully`
  String get update_category_success {
    return Intl.message(
      'Category updated successfully',
      name: 'update_category_success',
      desc: '',
      args: [],
    );
  }

  /// `Error updating category`
  String get update_category_error {
    return Intl.message(
      'Error updating category',
      name: 'update_category_error',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteWord {
    return Intl.message(
      'Delete',
      name: 'deleteWord',
      desc: '',
      args: [],
    );
  }

  /// `Access Users`
  String get accessUsers {
    return Intl.message(
      'Access Users',
      name: 'accessUsers',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to clipboard`
  String get copyTextSuccess {
    return Intl.message(
      'Text copied to clipboard',
      name: 'copyTextSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error copying text`
  String get copyTextError {
    return Intl.message(
      'Error copying text',
      name: 'copyTextError',
      desc: '',
      args: [],
    );
  }

  /// `Delete User`
  String get deleteUser {
    return Intl.message(
      'Delete User',
      name: 'deleteUser',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this user?`
  String get deleteUserHint {
    return Intl.message(
      'Are you sure you want to delete this user?',
      name: 'deleteUserHint',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get Image {
    return Intl.message(
      'Image',
      name: 'Image',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get Video {
    return Intl.message(
      'Video',
      name: 'Video',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get Audio {
    return Intl.message(
      'Audio',
      name: 'Audio',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get Files {
    return Intl.message(
      'Files',
      name: 'Files',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get Location {
    return Intl.message(
      'Location',
      name: 'Location',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get Text {
    return Intl.message(
      'Text',
      name: 'Text',
      desc: '',
      args: [],
    );
  }

  /// `No chats available`
  String get noChatsAvailable {
    return Intl.message(
      'No chats available',
      name: 'noChatsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `OTP sent successfully`
  String get send_otp_success {
    return Intl.message(
      'OTP sent successfully',
      name: 'send_otp_success',
      desc: '',
      args: [],
    );
  }

  /// `Error sending OTP`
  String get send_otp_error {
    return Intl.message(
      'Error sending OTP',
      name: 'send_otp_error',
      desc: '',
      args: [],
    );
  }

  /// `OTP verified successfully`
  String get verify_otp_success {
    return Intl.message(
      'OTP verified successfully',
      name: 'verify_otp_success',
      desc: '',
      args: [],
    );
  }

  /// `Error verifying OTP`
  String get verify_otp_error {
    return Intl.message(
      'Error verifying OTP',
      name: 'verify_otp_error',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully`
  String get reset_password_success {
    return Intl.message(
      'Password reset successfully',
      name: 'reset_password_success',
      desc: '',
      args: [],
    );
  }

  /// `Error resetting password`
  String get reset_password_error {
    return Intl.message(
      'Error resetting password',
      name: 'reset_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get change_password_success {
    return Intl.message(
      'Password changed successfully',
      name: 'change_password_success',
      desc: '',
      args: [],
    );
  }

  /// `Error changing password`
  String get change_password_error {
    return Intl.message(
      'Error changing password',
      name: 'change_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get change_password_hint {
    return Intl.message(
      'Enter new password',
      name: 'change_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully`
  String get add_product_success {
    return Intl.message(
      'Product added successfully',
      name: 'add_product_success',
      desc: '',
      args: [],
    );
  }

  /// `Error adding product`
  String get add_product_error {
    return Intl.message(
      'Error adding product',
      name: 'add_product_error',
      desc: '',
      args: [],
    );
  }

  /// `Course added successfully`
  String get add_course_success {
    return Intl.message(
      'Course added successfully',
      name: 'add_course_success',
      desc: '',
      args: [],
    );
  }

  /// `Error adding course`
  String get add_course_error {
    return Intl.message(
      'Error adding course',
      name: 'add_course_error',
      desc: '',
      args: [],
    );
  }

  /// `About Course`
  String get about_course {
    return Intl.message(
      'About Course',
      name: 'about_course',
      desc: '',
      args: [],
    );
  }

  /// `Enter course description`
  String get about_course_hint {
    return Intl.message(
      'Enter course description',
      name: 'about_course_hint',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message(
      'Lesson',
      name: 'lesson',
      desc: '',
      args: [],
    );
  }

  /// `Add Lesson Title`
  String get add_lesson_title_hint {
    return Intl.message(
      'Add Lesson Title',
      name: 'add_lesson_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item?`
  String get delete_item_label {
    return Intl.message(
      'Are you sure you want to delete this item?',
      name: 'delete_item_label',
      desc: '',
      args: [],
    );
  }

  /// `Item deleted successfully`
  String get delete_item_success {
    return Intl.message(
      'Item deleted successfully',
      name: 'delete_item_success',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting item`
  String get delete_item_error {
    return Intl.message(
      'Error deleting item',
      name: 'delete_item_error',
      desc: '',
      args: [],
    );
  }

  /// `Make Request`
  String get make_request {
    return Intl.message(
      'Make Request',
      name: 'make_request',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get mark_all_as_read {
    return Intl.message(
      'Mark all as read',
      name: 'mark_all_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get delete_all {
    return Intl.message(
      'Delete all notifications',
      name: 'delete_all',
      desc: '',
      args: [],
    );
  }

  /// `No notifications available`
  String get no_notifications {
    return Intl.message(
      'No notifications available',
      name: 'no_notifications',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred`
  String get error {
    return Intl.message(
      'An error has occurred',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get just_now {
    return Intl.message(
      'Just now',
      name: 'just_now',
      desc: '',
      args: [],
    );
  }

  /// `Minutes ago`
  String get minutes_ago {
    return Intl.message(
      'Minutes ago',
      name: 'minutes_ago',
      desc: '',
      args: [],
    );
  }

  /// `Hours ago`
  String get hours_ago {
    return Intl.message(
      'Hours ago',
      name: 'hours_ago',
      desc: '',
      args: [],
    );
  }

  /// `Days ago`
  String get days_ago {
    return Intl.message(
      'Days ago',
      name: 'days_ago',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get delete_all_notifications {
    return Intl.message(
      'Delete all notifications',
      name: 'delete_all_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get are_you_sure_delete {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'are_you_sure_delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Enroll Now`
  String get enroll_now {
    return Intl.message(
      'Enroll Now',
      name: 'enroll_now',
      desc: '',
      args: [],
    );
  }

  /// `Request sent successfully`
  String get request_sent {
    return Intl.message(
      'Request sent successfully',
      name: 'request_sent',
      desc: '',
      args: [],
    );
  }

  /// `Error sending request`
  String get request_error {
    return Intl.message(
      'Error sending request',
      name: 'request_error',
      desc: '',
      args: [],
    );
  }

  /// `Request accepted successfully`
  String get request_accepted {
    return Intl.message(
      'Request accepted successfully',
      name: 'request_accepted',
      desc: '',
      args: [],
    );
  }

  /// `Request rejected successfully`
  String get request_rejected {
    return Intl.message(
      'Request rejected successfully',
      name: 'request_rejected',
      desc: '',
      args: [],
    );
  }

  /// `Go to my requests`
  String get go_my_requests {
    return Intl.message(
      'Go to my requests',
      name: 'go_my_requests',
      desc: '',
      args: [],
    );
  }

  /// `My Requests`
  String get my_requests {
    return Intl.message(
      'My Requests',
      name: 'my_requests',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Request`
  String get cancel_request {
    return Intl.message(
      'Cancel Request',
      name: 'cancel_request',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this request?`
  String get cancel_request_hint {
    return Intl.message(
      'Are you sure you want to cancel this request?',
      name: 'cancel_request_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmWord {
    return Intl.message(
      'Confirm',
      name: 'confirmWord',
      desc: '',
      args: [],
    );
  }

  /// `Display all users`
  String get display_all_users {
    return Intl.message(
      'Display all users',
      name: 'display_all_users',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get update_profile_success {
    return Intl.message(
      'Profile updated successfully',
      name: 'update_profile_success',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get update_profile_error {
    return Intl.message(
      'Error updating profile',
      name: 'update_profile_error',
      desc: '',
      args: [],
    );
  }

  /// `Error loading data`
  String get error_loading_data {
    return Intl.message(
      'Error loading data',
      name: 'error_loading_data',
      desc: '',
      args: [],
    );
  }

  /// `something went wrong`
  String get error_load {
    return Intl.message(
      'something went wrong',
      name: 'error_load',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `No more data available`
  String get no_more_data {
    return Intl.message(
      'No more data available',
      name: 'no_more_data',
      desc: '',
      args: [],
    );
  }

  /// `Error loading more courses Tap to retry`
  String get retry_load_course {
    return Intl.message(
      'Error loading more courses Tap to retry',
      name: 'retry_load_course',
      desc: '',
      args: [],
    );
  }

  /// `Error loading more products Tap to retry`
  String get retry_load_product {
    return Intl.message(
      'Error loading more products Tap to retry',
      name: 'retry_load_product',
      desc: '',
      args: [],
    );
  }

  /// `Error loading more data Tap to retry`
  String get retry_load_more {
    return Intl.message(
      'Error loading more data Tap to retry',
      name: 'retry_load_more',
      desc: '',
      args: [],
    );
  }

  /// `No items in favorite`
  String get no_item_in_favorite {
    return Intl.message(
      'No items in favorite',
      name: 'no_item_in_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get areYouSureDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'areYouSureDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get deleteAccountSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'deleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while deleting the account.`
  String get deleteAccountError {
    return Intl.message(
      'An error occurred while deleting the account.',
      name: 'deleteAccountError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get home {
    return Intl.message(
      '',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get chat {
    return Intl.message(
      '',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get favorite {
    return Intl.message(
      '',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get profile {
    return Intl.message(
      '',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Update success`
  String get update_success {
    return Intl.message(
      'Update success',
      name: 'update_success',
      desc: '',
      args: [],
    );
  }

  /// `Update error`
  String get update_error {
    return Intl.message(
      'Update error',
      name: 'update_error',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get rejectWord {
    return Intl.message(
      'Reject',
      name: 'rejectWord',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptWord {
    return Intl.message(
      'Accept',
      name: 'acceptWord',
      desc: '',
      args: [],
    );
  }

  /// `Make Review`
  String get make_review {
    return Intl.message(
      'Make Review',
      name: 'make_review',
      desc: '',
      args: [],
    );
  }

  /// `Enter your review`
  String get review_hint {
    return Intl.message(
      'Enter your review',
      name: 'review_hint',
      desc: '',
      args: [],
    );
  }

  /// `Review submitted successfully`
  String get review_success {
    return Intl.message(
      'Review submitted successfully',
      name: 'review_success',
      desc: '',
      args: [],
    );
  }

  /// `Error submitting review`
  String get review_error {
    return Intl.message(
      'Error submitting review',
      name: 'review_error',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Enter User ID`
  String get search_user_label {
    return Intl.message(
      'Enter User ID',
      name: 'search_user_label',
      desc: '',
      args: [],
    );
  }

  /// `Searching...`
  String get searching {
    return Intl.message(
      'Searching...',
      name: 'searching',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `User found`
  String get search_user_success {
    return Intl.message(
      'User found',
      name: 'search_user_success',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get search_user_error {
    return Intl.message(
      'User not found',
      name: 'search_user_error',
      desc: '',
      args: [],
    );
  }

  /// `Error loading user`
  String get error_user_loag {
    return Intl.message(
      'Error loading user',
      name: 'error_user_loag',
      desc: '',
      args: [],
    );
  }

  /// `No more user available`
  String get no_more_user {
    return Intl.message(
      'No more user available',
      name: 'no_more_user',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get required_field {
    return Intl.message(
      'This field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Tobic`
  String get tobic {
    return Intl.message(
      'Tobic',
      name: 'tobic',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get total_price {
    return Intl.message(
      'Total Price',
      name: 'total_price',
      desc: '',
      args: [],
    );
  }

  /// `Instructor`
  String get instructor {
    return Intl.message(
      'Instructor',
      name: 'instructor',
      desc: '',
      args: [],
    );
  }

  /// `No reviews yet`
  String get no_reviews {
    return Intl.message(
      'No reviews yet',
      name: 'no_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Certificate`
  String get certificate {
    return Intl.message(
      'Certificate',
      name: 'certificate',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message(
      'Lessons',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled successfully`
  String get request_cancelled {
    return Intl.message(
      'Request cancelled successfully',
      name: 'request_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `No Course Title`
  String get no_course_title {
    return Intl.message(
      'No Course Title',
      name: 'no_course_title',
      desc: '',
      args: [],
    );
  }

  /// `Request ID:`
  String get request_id {
    return Intl.message(
      'Request ID:',
      name: 'request_id',
      desc: '',
      args: [],
    );
  }

  /// `Label`
  String get labelWord {
    return Intl.message(
      'Label',
      name: 'labelWord',
      desc: '',
      args: [],
    );
  }

  /// `My Products`
  String get my_products {
    return Intl.message(
      'My Products',
      name: 'my_products',
      desc: '',
      args: [],
    );
  }

  /// `My Courses`
  String get my_courses {
    return Intl.message(
      'My Courses',
      name: 'my_courses',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get delete_account_success {
    return Intl.message(
      'Account deleted successfully',
      name: 'delete_account_success',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting account`
  String get delete_account_error {
    return Intl.message(
      'Error deleting account',
      name: 'delete_account_error',
      desc: '',
      args: [],
    );
  }

  /// ` deleted successfully`
  String get delete_product_success {
    return Intl.message(
      ' deleted successfully',
      name: 'delete_product_success',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting `
  String get delete_product_error {
    return Intl.message(
      'Error deleting ',
      name: 'delete_product_error',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Contact Support`
  String get contactSupport {
    return Intl.message(
      'Contact Support',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `No product found`
  String get no_product_found {
    return Intl.message(
      'No product found',
      name: 'no_product_found',
      desc: '',
      args: [],
    );
  }

  /// `No course found`
  String get no_course_found {
    return Intl.message(
      'No course found',
      name: 'no_course_found',
      desc: '',
      args: [],
    );
  }

  /// `Type to search`
  String get type_to_search {
    return Intl.message(
      'Type to search',
      name: 'type_to_search',
      desc: '',
      args: [],
    );
  }

  /// `Please select an image`
  String get Please_select_an_image {
    return Intl.message(
      'Please select an image',
      name: 'Please_select_an_image',
      desc: '',
      args: [],
    );
  }

  /// `Please add lessons`
  String get add_lesson_error {
    return Intl.message(
      'Please add lessons',
      name: 'add_lesson_error',
      desc: '',
      args: [],
    );
  }

  /// `this field is required`
  String get text_field_enter_req {
    return Intl.message(
      'this field is required',
      name: 'text_field_enter_req',
      desc: '',
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
