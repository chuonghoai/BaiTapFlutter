import 'package:flutter/material.dart';
import '../controllers/team_controller.dart';
import '../models/team_member.dart';
// QUAN TRỌNG: Cần import AppRouter để lấy tên route
import '../core/app_router.dart'; 

class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  final TeamController _controller = TeamController();
  late Future<List<TeamMember>> _teamFuture;

  @override
  void initState() {
    super.initState();
    _teamFuture = _controller.getTeamData();
    _controller.startTimerToLogin(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin Nhóm'),
        leading: IconButton(
          icon: const Icon(Icons.refresh_outlined),
          tooltip: 'Làm mới màn hình và đếm ngược',
          onPressed: () {
            _controller.dispose(); 
            Navigator.pushReplacementNamed(context, AppRouter.teamRoute);
          },
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ValueListenableBuilder<int>(
                valueListenable: _controller.countdown,
                builder: (context, value, child) {
                  return Text(
                    'Chuyển sau: ${value}s',
                    style: const TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.red
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<TeamMember>>(
        future: _teamFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final team = snapshot.data!;
            return ListView.builder(
              itemCount: team.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(team[index].name),
                  subtitle: Text(team[index].role),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}