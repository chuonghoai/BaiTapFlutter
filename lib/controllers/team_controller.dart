import 'dart:async';
import 'package:flutter/material.dart';
import '../models/team_member.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class TeamController {
  final AppService _service = AppService();
  
  final ValueNotifier<int> countdown = ValueNotifier<int>(10);
  Timer? _timer;

  Future<List<TeamMember>> getTeamData() {
    return _service.fetchTeamMembers();
  }

  void startTimerToLogin(BuildContext context) {
    countdown.value = 10;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        _timer?.cancel();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
        }
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    countdown.dispose();
  }
}