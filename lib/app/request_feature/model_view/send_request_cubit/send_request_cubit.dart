import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/notification/data/notification_services.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/request_feature/data/repositories/i_request_repository.dart';

part 'send_request_state.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());
  final IRequestRepository _repo = RequestRepository();

  Future<void> sendRequest(String courseId, Partner partner) async {
    emit(SendRequestLoading());
    final result = await _repo.sendRequest(courseId);
    result.fold(
      (l) => emit(SendRequestError()),
      (r) {
        NotificationService.instance.sendPushNotification(
          type: "request",
          partner: partner,
          title: "new request",
          body: "You have a new request",
        );
        emit(SendRequestSuccess());
      },
    );
  }
}
