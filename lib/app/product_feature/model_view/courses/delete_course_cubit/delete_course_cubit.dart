import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'delete_course_state.dart';

class DeleteCourseCubit extends Cubit<DeleteCourseState> {
  DeleteCourseCubit() : super(DeleteCourseInitial());
  final CourseRepository _courseRepository = CourseRepository();

  Future<void> deleteCourse(String id) async {
    emit(DeleteCourseLoading());
    final result = await _courseRepository.deleteCourse(id);
    result.fold((l) => emit(DeleteCourseError()), (r) {
      emit(DeleteCourseSuccess());
    });
  }
}
