import 'package:bloc/bloc.dart';
import 'package:snap_deals/app/request_feature/data/model/request/request.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';
import 'package:snap_deals/app/request_feature/model_view/get_my_request_cubit/get_my_request_state.dart';

class GetMyRequestsCubit extends Cubit<GetMyRequestsState> {
  GetMyRequestsCubit() : super(GetMyRequestsInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> getMyRequests() async {
    emit(GetMyRequestsLoading());
    final result = await _repo.getMyRequest();
    result.fold((l) => emit(GetMyRequestsError()), (r) {
      final List requestsMap = r["data"];
      final List<RequestModel> requests =
          requestsMap.map((request) => RequestModel.fromJson(request)).toList();
      emit(GetMyRequestsSuccess(requests: requests));
    });
  }
}
