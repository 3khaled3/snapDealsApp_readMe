part of 'get_my_courses_cubit.dart';

sealed class GetMyCoursesState extends Equatable {
  const GetMyCoursesState();

  @override
  List<Object> get props => [];
}

final class GetMyCoursesInitial extends GetMyCoursesState {}
final class GetMyCoursesLoading extends GetMyCoursesState {}
final class GetMyCoursesError extends GetMyCoursesState {}
final class GetMyCoursesSuccess extends GetMyCoursesState {
  final List<CourseModel> courses;
  const GetMyCoursesSuccess({required this.courses});
}

