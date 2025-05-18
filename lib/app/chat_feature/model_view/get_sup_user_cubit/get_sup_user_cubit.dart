import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/auth_feature/data/repositories/auth_repository/i_auth_repository.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

part 'get_sup_user_state.dart';

class GetSupUserCubit extends Cubit<GetSupUserState> {
  GetSupUserCubit() : super(GetSupUserInitial());

  static List<Partner> userList = [];
  Future<void> getSupUser(userId) async {
    if (userList.isNotEmpty) {
      for (int i = 0; i < userList.length; i++) {
        if (userList[i].id == userId) {
          emit(GetSupUserSuccess(user: userList[i]));
          return;
        }
      }
    }
    emit(GetSupUserLoading());
    final result =
        await AuthRepositoryImpl.instance.getSpecificUserData(userId);

    result.fold((l) {
      emit(GetSupUserError(message: l.message ?? ""));
    }, (r) async {
      final user = Partner.fromJson(r["data"] as Map<String, dynamic>);
      emit(GetSupUserSuccess(user: user));
      userList.add(user);
    });
  }
}
