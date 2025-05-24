import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'get_my_courses_state.dart';

class GetMyCoursesCubit extends Cubit<GetMyCoursesState> {
  GetMyCoursesCubit() : super(GetMyCoursesInitial());

   final ICourseRepository _courseRepository = CourseRepository();

  Future<void> getMyCourses(
      {required String limit, required String page,required String uesrId}) async {
    emit(GetMyCoursesLoading());
    final result = await _courseRepository.getMyCourses(limit: limit, page: page,uesrId: uesrId);
    result.fold((l) => emit(GetMyCoursesError()), (r) {
      final List coursesMap = r["data"];
      final List<CourseModel> courses =
          coursesMap.map((course) => CourseModel.fromJson(course)).toList();
      emit(GetMyCoursesSuccess(courses:courses));
    });
  }
}
