part of 'create_course_cubit.dart';

sealed class CreateCourseState extends Equatable {
  const CreateCourseState();

  @override
  List<Object> get props => [];
}

final class CreateCourseInitial extends CreateCourseState {}

final class CreateCourseLoading extends CreateCourseState {}

final class CreateCourseSuccess extends CreateCourseState {}

final class CreateCourseError extends CreateCourseState {}
