part of "i_course_repository.dart";

class CourseRepository implements ICourseRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> createCourse(
      CourseModel course, XFile image) async {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postFile(
        linkUrl: ApiEndpoints.courses,
        token: token,
        file: File(image.path),
        name: "images",
        field: course.createCourseFormData(), // تم التعديل هنا
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getCourseById(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.courseById(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getCourses(
      {required String limit, required String page}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: "${ApiEndpoints.courses}?page=$page&limit=$limit",
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getMyCourses(
      {required String limit, required String page, required String uesrId}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl:
            "${ApiEndpoints.courses}?page=$page&limit=$limit&instructor=$uesrId",
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getCoursesByCategory(
      String id) {
    // TODO: implement getCoursesByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> increaseView(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.patchData(
        data: {},
        linkUrl: ApiEndpoints.courseViews(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> deleteCourse(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.courseById(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> updateCourse(
      CourseModel course,Map<String, dynamic> data) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.putData(
        linkUrl: ApiEndpoints.courseById(course.id),
        data: data,
        token: token,
      ),
    );
  }
}
