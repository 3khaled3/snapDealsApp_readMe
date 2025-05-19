import 'package:bloc/bloc.dart';
import 'package:snap_deals/app/request_feature/data/model/instractor/instractor.request.model.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';

import 'get_requests_by_id_state.dart';

class GetRequestsByIdCubit extends Cubit<GetRequestsByIdState> {
  GetRequestsByIdCubit() : super(GetRequestsByIdInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> getRequestsById(String courseId) async {
    emit(GetRequestsByIdLoading());
    final result = await _repo.getRequestsById(courseId);
    result.fold(
      (l) => emit(GetRequestsByIdError()),
      (r) {
         final List requestsMap = r["data"];
      final List<InstractorRequestModel> requests =
          requestsMap.map((request) => InstractorRequestModel.fromJson(request)).toList();
          emit(GetRequestsByIdSuccess( requests));
      },
    );
  }
}
