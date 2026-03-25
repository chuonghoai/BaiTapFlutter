import 'package:flutter/material.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class LoginController {
  final AppService _service = AppService();

  Future<void> handleLogin(
      BuildContext context, String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _showSnackbar(context, 'Vui lòng nhập đầy đủ thông tin');
      return;
    }

    try {
      // 1. Gọi login → nhận token
      final loginRes = await _service.login(username, password);
      await _service.saveToken(loginRes.token);

      // 2. Gọi getMe() → kiểm tra role
      final user = await _service.getMe(loginRes.token);

      if (!context.mounted) return;

      if (user.role != 'ADMIN') {
        // Không phải ADMIN → xóa token, về login
        await _service.clearToken();
        _showSnackbar(context, 'Không có quyền truy cập');
        return;
      }

      // 3. ADMIN → vào dashboard
      Navigator.pushReplacementNamed(
        context,
        AppRouter.dashboardRoute,
        arguments: user,
      );
    } catch (e) {
      if (context.mounted) {
        _showSnackbar(context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
    );
  }
}