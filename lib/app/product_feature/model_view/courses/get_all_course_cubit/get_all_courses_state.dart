part of 'get_all_courses_cubit.dart';

sealed class GetAllCoursesState extends Equatable {
  const GetAllCoursesState();

  @override
  List<Object> get props => [];
}

final class GetAllCoursesInitial extends GetAllCoursesState {}

final class GetAllCoursesSuccess extends GetAllCoursesState {
  final List<CourseModel> courses;
  const GetAllCoursesSuccess(this.courses);
}

final class GetAllCoursesError extends GetAllCoursesState {}

final class GetAllCoursesLoading extends GetAllCoursesState {}
