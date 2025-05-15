import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';

part 'cancel_request_state.dart';

class CancelRequestCubit extends Cubit<CancelRequestState> {
  CancelRequestCubit() : super(CancelRequestInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> cancelRequest(String requestId) async {
    emit(CancelRequestLoading());
    final result = await _repo.cancelRequest(requestId);
    result.fold(
      (l) => emit(CancelRequestError()),
      (r) => emit(CancelRequestSuccess()),
    );
  }
}