import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:snap_deals/app/auth_feature/data/repositories/forget_password_repository/i_forget_password_repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  final ForgetPasswordRepoImpl _forgetPasswordRepoImpl =
      ForgetPasswordRepoImpl();

  newPassword({required String email, required String newPassword}) async {
    emit(SavePasswordLoading());
    final result = await _forgetPasswordRepoImpl.newPassword(
        email: email, newPassword: newPassword);
    result.fold(
      (left) {
        emit(SavePasswordError(left.message ?? "Error updating password"));
      },
      (right) {
        emit(const SavePasswordSuccess("Password updated successfully"));
      },
    );
  }

  sendOTP({required String email}) async {
    emit(SendOtpLoading());
    final result = await _forgetPasswordRepoImpl.sendOTP(email: email);
    result.fold(
      (left) {
        emit(SendOtpError(left.message ?? "Error sending OTP"));
      },
      (right) {
        emit(const SendOtpSuccess("OTP sent successfully"));
      },
    );
  }

  verifyOTP({required String otp}) async {
    emit(VerifyOtpLoading());
    final result = await _forgetPasswordRepoImpl.verifyOTP(otp: otp);
    result.fold(
      (left) {
        emit(VerifyOtpError(left.message ?? "Error verifying OTP"));
      },
      (right) {
        emit(const VerifyOtpSuccess("OTP verified successfully"));
      },
    );
  }
}
