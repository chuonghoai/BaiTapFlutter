import 'package:flutter/material.dart';
import '../views/team_view.dart';
import '../views/login_view.dart';
import '../views/success_view.dart';

class AppRouter {
  static const String teamRoute = '/';
  static const String loginRoute = '/login';
  static const String successRoute = '/success';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case teamRoute:
        return MaterialPageRoute(builder: (_) => const TeamView());
      
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      
      case successRoute:
        final message = settings.arguments as String? ?? 'Thành công';
        return MaterialPageRoute(builder: (_) => SuccessView(message: message));
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Không tìm thấy màn hình: ${settings.name}')),
          ),
        );
    }
  }
}