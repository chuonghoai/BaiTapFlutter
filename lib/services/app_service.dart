import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api_endpoint.dart';
import '../models/user_model.dart';
import '../models/login_response_model.dart';

class AppService {
  // ─── Token helpers ────────────────────────────────────────────────────────
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  // ─── Auth APIs ────────────────────────────────────────────────────────────

  /// Trả về LoginResponseModel nếu thành công, throw Exception nếu lỗi.
  Future<LoginResponseModel> login(String username, String password) async {
    final res = await http.post(
      Uri.parse(ApiEndpoint.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) {
      return LoginResponseModel.fromJson(body['data']);
    }
    throw Exception(body['message'] ?? 'Đăng nhập thất bại');
  }

  /// Trả về message thành công, throw Exception nếu lỗi.
  Future<String> register(String username, String password, String email) async {
    final res = await http.post(
      Uri.parse(ApiEndpoint.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password, 'email': email}),
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) return body['message'];
    throw Exception(body['message'] ?? 'Đăng ký thất bại');
  }

  /// Xác thực OTP sau đăng ký.
  Future<String> verifyOtp(String email, String otp) async {
    final res = await http.post(
      Uri.parse(ApiEndpoint.verifyOtp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) return body['message'];
    throw Exception(body['message'] ?? 'OTP không hợp lệ');
  }

  /// Gửi OTP về email để reset password.
  Future<String> forgotPassword(String email) async {
    final res = await http.post(
      Uri.parse(ApiEndpoint.forgotPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) return body['message'];
    throw Exception(body['message'] ?? 'Email không tồn tại');
  }

  /// Đặt lại mật khẩu.
  Future<String> resetPassword(String email, String otp, String newPassword) async {
    final res = await http.post(
      Uri.parse(ApiEndpoint.resetPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp, 'newPassword': newPassword}),
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) return body['message'];
    throw Exception(body['message'] ?? 'Đặt lại mật khẩu thất bại');
  }

  /// Lấy thông tin user hiện tại từ JWT.
  Future<UserModel> getMe(String token) async {
    final res = await http.get(
      Uri.parse(ApiEndpoint.getMe),
      headers: {'Authorization': 'Bearer $token'},
    );
    final body = jsonDecode(res.body);
    if (body['success'] == true) {
      return UserModel.fromJson(body['data']);
    }
    throw Exception(body['message'] ?? 'Không lấy được thông tin');
  }
}