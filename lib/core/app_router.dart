import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/forgot_password_view.dart';
import '../views/dashboard_view.dart';
import '../models/user_model.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String dashboardRoute = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case dashboardRoute:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => DashboardView(user: user));

      default:
        return MaterialPageRoute(builder: (_) => const LoginView());
    }
  }
}