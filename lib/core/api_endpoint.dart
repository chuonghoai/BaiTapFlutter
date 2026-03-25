class ApiEndpoint {
  static const String baseUrl = "http://10.0.2.2:8087";

  static const String login = "$baseUrl/api/auth/login";
  static const String register = "$baseUrl/api/auth/register";
  static const String verifyOtp = "$baseUrl/api/auth/verify-otp";
  static const String forgotPassword = "$baseUrl/api/auth/forgot-password";
  static const String resetPassword = "$baseUrl/api/auth/reset-password";
  static const String getMe = "$baseUrl/api/auth/me/get";
}