abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl =
      "https://bilaldollan.pythonanywhere.com";

  //! auth
  static const String userSignUp = '$_baseUrl/api/v1/user/signup/';
  static const String userLogin = '$_baseUrl/accounts/login/';
  static const String userLogOut = '$_baseUrl/accounts/logout/';
  static const String requestOtp = '$_baseUrl/accounts/request-otp/';
  static const String verifyOtp = '$_baseUrl/accounts/verify-otp/';
  static const String changePassword = '$_baseUrl/accounts/change-password/';
  static const String refreshAccessToken =
      '$_baseUrl/accounts/api/token/refresh/';

  //! profile
  static const String profile = '$_baseUrl/accounts/profile/';

  //! profile
  static const String getUserData = '$_baseUrl/accounts/profile/';

  //! blogs
  static const String getBlogs = '$_baseUrl/blogs/';
  static const String getBlogsCategory = '$_baseUrl/categories/';
  static const String getCategoryBlogs = '$_baseUrl/blogs/category';

  static const String createBlogs = '$_baseUrl/blogs/';

  //! groups
  static const String getGroups = '$_baseUrl/groups/';
  static const String getUserGroups = '$_baseUrl/user/groups/';
  static const String joinGroup = '$_baseUrl/groups/';
}
