import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'update_course_state.dart';

class UpdateCourseCubit extends Cubit<UpdateCourseState> {
  UpdateCourseCubit() : super(UpdateCourseInitial());
  final ICourseRepository _courseRepository = CourseRepository();
  Future<void> updateCourse(CourseModel course,Map<String, dynamic> data) async {
    emit(UpdateCourseLoading());
    final result = await _courseRepository.updateCourse(course, data);
    result.fold((l) => emit(UpdateCourseError()), (r) {
      emit(UpdateCourseSuccess());
    });
  }
}
