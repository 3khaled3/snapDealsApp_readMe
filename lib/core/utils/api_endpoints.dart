class ApiEndpoints {
  static const String baseUrl =
      'https://g-project-git-zuheir-zuheirs-projects.vercel.app/api/v1';

  // Categories
  static const String categories = '$baseUrl/categories';
  static String categoryById(String id) => '$categories/$id';

  // Products
  static const String products = '$baseUrl/products';
  static String productById(String id) => '$products/$id';
  static String productViews(String id) => '$products/$id/views';

  // Users
  static const String users = '$baseUrl/users';
  static String userById(String id) => '$users/$id';
  static String changeUserPassword(String id) => '$users/changePassword/$id';
  static const String getMe = '$users/getMe';
  static const String changeMyPassword = '$users/changeMyPassword';
  static const String updateMe = '$users/updateMe';
  static const String deleteMe = '$users/deleteMe';

  // Auth
  static const String signup = '$baseUrl/auth/signup';
  static const String login = '$baseUrl/auth/login';
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$baseUrl/auth/verifyPassResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';

  // Requests
  static const String myRequests = '$baseUrl/requests/my-requests';
  static String requestById(String id) => '$baseUrl/requests/$id';
  static String approveRequest(String id) => '$baseUrl/requests/approve/$id';
  static String rejectRequest(String id) => '$baseUrl/requests/reject/$id';
  static String cancelRequest(String id) => '$baseUrl/requests/$id/cancel';

  // Favorites
  static const String favorites = '$baseUrl/favorites';
  static String favoriteById(String id) => '$favorites/$id';

  // Courses
  static const String courses = '$baseUrl/courses';
  static String courseById(String id) => '$courses/$id';
  static String courseViews(String id) => '$courses/$id/views';

  // Reviews
  static String reviewById(String id) => '$baseUrl/reviews/$id';
  static String reviewsOf(String id) => '$baseUrl/reviews/$id/reviews';
}
