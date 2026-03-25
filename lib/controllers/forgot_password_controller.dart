import 'package:flutter/material.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class ForgotPasswordController {
  final AppService _service = AppService();

  /// Bước 1: Gửi OTP về email
  Future<void> handleForgotPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      _showSnackbar(context, 'Vui lòng nhập email', isError: true);
      return;
    }
    try {
      final message = await _service.forgotPassword(email);
      if (context.mounted) {
        _showSnackbar(context, message, isError: false);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackbar(context, e.toString().replaceFirst('Exception: ', ''), isError: true);
      }
    }
  }

  /// Bước 2: Đặt lại mật khẩu bằng OTP
  Future<void> handleResetPassword(BuildContext context, String email,
      String otp, String newPassword) async {
    if (otp.isEmpty || newPassword.isEmpty) {
      _showSnackbar(context, 'Vui lòng nhập đầy đủ thông tin', isError: true);
      return;
    }
    try {
      final message = await _service.resetPassword(email, otp, newPassword);
      if (context.mounted) {
        _showSnackbar(context, message, isError: false);
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackbar(context, e.toString().replaceFirst('Exception: ', ''), isError: true);
      }
    }
  }

  void _showSnackbar(BuildContext context, String message,
      {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
    ));
  }
}
