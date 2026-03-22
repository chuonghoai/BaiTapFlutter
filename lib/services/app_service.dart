import '../models/team_member.dart';

class AppService {
  Future<List<TeamMember>> fetchTeamMembers() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      TeamMember(id: '1', name: 'Phạm Hoài Nam', role: 'Frontend'),
      TeamMember(id: '2', name: 'Trương Hoài Chương', role: 'Backend'),
    ];
  }

  Future<String> loginManager(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return "Đăng nhập thành công"; 
  }
}