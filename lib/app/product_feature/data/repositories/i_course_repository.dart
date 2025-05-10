
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';

part "course_repository.dart";
abstract class ICourseRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> getCourses({ required String limit ,required String page });
  Future<Either<FailureModel, Map<String, dynamic>>> getCourseById(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> getCoursesByCategory(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> createCourse(CourseModel course,XFile image);
  Future<Either<FailureModel, Map<String, dynamic>>> updateCourse(CourseModel course);
  Future<Either<FailureModel, Map<String, dynamic>>> deleteCourse(String id);  
  Future<Either<FailureModel, Map<String, dynamic>>> increaseView(String id);  

 
}