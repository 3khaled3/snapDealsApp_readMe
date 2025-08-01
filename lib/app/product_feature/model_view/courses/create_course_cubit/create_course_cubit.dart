import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'create_course_state.dart';

class CreateCourseCubit extends Cubit<CreateCourseState> {
  CreateCourseCubit() : super(CreateCourseInitial());
  final _courseRepository = CourseRepository();

  Future<void> createCourse(CourseModel course, XFile image) async {
    emit(CreateCourseLoading());
    final result = await _courseRepository.createCourse(course, image);
    result.fold((l) => emit(CreateCourseError()), (r) {
      emit(CreateCourseSuccess());
    });
  }
}
