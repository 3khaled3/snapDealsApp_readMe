class ApiEndpoints {
  // Base URL for local or deployed server
  // static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
  // If deployed, switch to:
  static const String baseUrl = 'https://your-deployed-url.com/api/v1';

  // Auth
  static const String login = '$baseUrl/auth/login';
  static const String signup = '$baseUrl/auth/signup';
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyPassResetCode = '$baseUrl/auth/verifyPassResetCode';

  // Users
  static const String users = '$baseUrl/users';

  // Products
  static const String products = '$baseUrl/products';
  static String singleProduct(String id) => '$products/$id';
  static const String lowRatedProducts = '$products?ratingsAverage[lt]=3';

  // Categories
  static const String categories = '$baseUrl/categories';
  static const String categoriesPage2 = '$baseUrl/categories?page=2';
  static String categoryById(String id) => '$categories/$id';

  // Favorites
  static const String favorites = '$baseUrl/favorites';
  static String favoriteById(String id) => '$favorites/$id';

  // Courses
  static const String courses = '$baseUrl/courses';
  static String courseById(String id) => '$courses/$id';

  // Reviews
  static String courseReviews(String courseId) => '$courses/$courseId/reviews';
  static String reviewsFor(String courseId) => '$baseUrl/reviews/$courseId';

  // Requests
  static String courseRequests(String courseId) => '$baseUrl/requests/$courseId';
  static const String myRequests = '$baseUrl/requests/my-requests';
  static String approveRequest(String requestId) => '$baseUrl/requests//approve/$requestId';
}
