import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:snap_deals/core/utils/failure_model.dart';
import 'package:snap_deals/core/utils/network_utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

 Future<Either<Failure, User?>> login() async {
   return await NetworkUtils.handleRequest(
        () => NetworkUtils.signInWithEmail('email', 'password'));
  }
}
