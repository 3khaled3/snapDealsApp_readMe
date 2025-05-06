import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'get_course_using_id_state.dart';

class GetCourseUsingIdCubit extends Cubit<GetCourseUsingIdState> {
  GetCourseUsingIdCubit() : super(GetCourseUsingIdInitial());
  final ICourseRepository _courseRepository = CourseRepository();

  Future<void> getCourseUsingId(String id) async {
    emit(GetCourseUsingIdLoading());
    final result = await _courseRepository.getCourseById(id);
    result.fold((l) => emit(GetCourseUsingIdError()), (r) {
      emit(GetCourseUsingIdSuccess(CourseModel.fromJson(r["data"])));
    });
  }
}
