import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';

part 'get_all_courses_state.dart';

class GetAllCoursesCubit extends Cubit<GetAllCoursesState> {
  GetAllCoursesCubit() : super(GetAllCoursesInitial());

  final ICourseRepository _courseRepository = CourseRepository();

  Future<void> getAllCourses(
      {required String limit, required String page}) async {
    emit(GetAllCoursesLoading());
    final result = await _courseRepository.getCourses(limit: limit, page: page);
    result.fold((l) {
      log("l.message ${l.message}");
      if (l.message == "لا توجد كورسات تطابق معايير البحث") {
        emit(const GetAllCoursesSuccess([]));
      } else {
        emit(GetAllCoursesError());
      }
    }, (r) {
      final List coursesMap = r["data"];
      final List<CourseModel> courses =
          coursesMap.map((course) => CourseModel.fromJson(course)).toList();
      emit(GetAllCoursesSuccess(courses));
    });
  }
}
