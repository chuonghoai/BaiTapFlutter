import 'package:flutter/material.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class RegisterController {
  final AppService _service = AppService();

  /// Bước 1: Gửi thông tin đăng ký → backend gửi OTP về email
  Future<void> handleSendOtp(
      BuildContext context, String email, String username, String password) async {
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showSnackbar(context, 'Vui lòng nhập đầy đủ thông tin', isError: true);
      return;
    }
    try {
      final message = await _service.register(username, password, email);
      if (context.mounted) {
        _showSnackbar(context, message, isError: false);
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackbar(context, e.toString().replaceFirst('Exception: ', ''), isError: true);
      }
    }
  }

  /// Bước 2: Xác thực OTP → nếu thành công, hiện dialog → về login
  Future<void> handleVerifyOtp(
      BuildContext context, String email, String otp) async {
    if (otp.isEmpty) {
      _showSnackbar(context, 'Vui lòng nhập OTP', isError: true);
      return;
    }
    try {
      await _service.verifyOtp(email, otp);
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('Thành công'),
            content:
                const Text('Đăng ký thành công, vui lòng đăng nhập lại'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // đóng dialog
                  Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
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
