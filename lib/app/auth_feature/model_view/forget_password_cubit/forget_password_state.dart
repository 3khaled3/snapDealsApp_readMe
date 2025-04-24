part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {
  const ForgetPasswordState();
}

/// Initial
final class ForgetPasswordInitial extends ForgetPasswordState {}

/// Generic Loading, Success, and Error
final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordSuccess(this.message);
}

final class ForgetPasswordError extends ForgetPasswordState {
  final String error;
  const ForgetPasswordError(this.error);
}

/// Step 1: Send OTP
final class SendOtpLoading extends ForgetPasswordState {}

final class SendOtpSuccess extends ForgetPasswordState {
  final String message;
  const SendOtpSuccess(this.message);
}

final class SendOtpError extends ForgetPasswordState {
  final String error;
  const SendOtpError(this.error);
}

/// Step 2: Verify OTP
final class VerifyOtpLoading extends ForgetPasswordState {}

final class VerifyOtpSuccess extends ForgetPasswordState {
  final String message;
  const VerifyOtpSuccess(this.message);
}

final class VerifyOtpError extends ForgetPasswordState {
  final String error;
  const VerifyOtpError(this.error);
}

/// Step 3: Save New Password
final class SavePasswordLoading extends ForgetPasswordState {}

final class SavePasswordSuccess extends ForgetPasswordState {
  final String message;
  const SavePasswordSuccess(this.message);
}

final class SavePasswordError extends ForgetPasswordState {
  final String error;
  const SavePasswordError(this.error);
}
