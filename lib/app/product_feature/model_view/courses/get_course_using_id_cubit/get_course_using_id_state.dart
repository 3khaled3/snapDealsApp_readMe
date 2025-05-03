part of 'get_course_using_id_cubit.dart';

sealed class GetCourseUsingIdState extends Equatable {
  const GetCourseUsingIdState();

  @override
  List<Object> get props => [];
}

final class GetCourseUsingIdInitial extends GetCourseUsingIdState {}

final class GetCourseUsingIdLoading extends GetCourseUsingIdState {}

final class GetCourseUsingIdSuccess extends GetCourseUsingIdState {
  final CourseModel course;
  const GetCourseUsingIdSuccess(this.course);
}

final class GetCourseUsingIdError extends GetCourseUsingIdState {}
