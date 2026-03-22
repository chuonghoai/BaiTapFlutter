import 'package:flutter/material.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class LoginController {
  final AppService _service = AppService();

  Future<void> handleLogin(BuildContext context, String username, String password) async {
    String message = await _service.loginManager(username, password);
    
    if (context.mounted) {
      Navigator.pushReplacementNamed(
        context, 
        AppRouter.successRoute,
        arguments: message,
      );
    }
  }
}