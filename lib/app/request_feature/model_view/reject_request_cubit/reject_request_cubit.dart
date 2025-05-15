import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';


part 'reject_request_state.dart';

class RejectRequestCubit extends Cubit<RejectRequestState> {
  RejectRequestCubit() : super(RejectRequestInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> rejectRequest(String requestId) async {
    emit(RejectRequestLoading());
    final result = await _repo.rejectRequest(requestId);
    result.fold(
      (l) => emit(RejectRequestError()),
      (r) => emit(RejectRequestSuccess()),
    );
  }
}