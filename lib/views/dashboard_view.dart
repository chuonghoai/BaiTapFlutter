import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/app_service.dart';
import '../core/app_router.dart';

class DashboardView extends StatelessWidget {
  final UserModel user;
  const DashboardView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        title: const Text(
          'Dashboard Admin',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Đăng xuất',
            onPressed: () async {
              await AppService().clearToken();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + tên
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: user.avatarUrl.isNotEmpty
                        ? NetworkImage(user.avatarUrl)
                        : null,
                    child: user.avatarUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.blue.shade700,
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.fullname.isNotEmpty ? user.fullname : user.username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.role,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Thông tin user
            const Text(
              'Thông tin tài khoản',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 12),
            _infoCard(
              children: [
                _infoRow(Icons.badge_outlined, 'ID', '${user.id}'),
                _divider(),
                _infoRow(Icons.person_outline, 'Username', user.username),
                _divider(),
                _infoRow(
                  Icons.drive_file_rename_outline,
                  'Họ tên',
                  user.fullname,
                ),
                _divider(),
                _infoRow(Icons.email_outlined, 'Email', user.email),
                _divider(),
                _infoRow(
                  Icons.phone_outlined,
                  'Số điện thoại',
                  user.phone.isNotEmpty ? user.phone : '(chưa cập nhật)',
                ),
                _divider(),
                _infoRow(
                  Icons.admin_panel_settings_outlined,
                  'Vai trò',
                  user.role,
                ),
                _divider(),
                _infoRow(
                  Icons.stars_outlined,
                  'Điểm thưởng',
                  '${user.rewardPoints} điểm',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(children: children),
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: Colors.grey.shade100, indent: 52);

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
