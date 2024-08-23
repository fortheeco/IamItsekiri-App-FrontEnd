abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl =
      "https://bilaldollan.pythonanywhere.com/api/v1";

  //! auth
  static const String userSignUp = '$_baseUrl/user/signup/';
  static const String userLogin = '$_baseUrl/user/login/';
  static const String userLogOut = '$_baseUrl/accounts/logout/';
  static const String requestSignUpOtp = '$_baseUrl/user/send/otp/';
  static const String verifyOtp = '$_baseUrl/user/verify/otp/';
  static const String changePassword = '$_baseUrl/accounts/change-password/';
  static const String refreshAccessToken = '$_baseUrl/user/token/refresh/';

  //! profile
  static const String profile = '$_baseUrl/user/update/';

  //! profile
  static const String getUserData = '$_baseUrl/user/information/';

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
