
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';


part 'approve_request_state.dart';

class ApproveRequestCubit extends Cubit<ApproveRequestState> {
  ApproveRequestCubit() : super(ApproveRequestInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> approveRequest(String requestId) async {
    emit(ApproveRequestLoading());
    final result = await _repo.approveRequest(requestId);
    result.fold(
      (l) => emit(ApproveRequestError()),
      (r) => emit(ApproveRequestSuccess()),
    );
  }
}