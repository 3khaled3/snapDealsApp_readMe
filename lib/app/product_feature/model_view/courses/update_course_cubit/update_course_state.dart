part of 'update_course_cubit.dart';

sealed class UpdateCourseState extends Equatable {
  const UpdateCourseState();

  @override
  List<Object> get props => [];
}

final class UpdateCourseInitial extends UpdateCourseState {}

final class UpdateCourseLoading extends UpdateCourseState {}

final class UpdateCourseSuccess extends UpdateCourseState {}

final class UpdateCourseError extends UpdateCourseState {}
