class UserModel {
  final int id;
  final String email;
  final String fullname;
  final String username;
  final String role;
  final String phone;
  final String avatarUrl;
  final int rewardPoints;

  UserModel({
    required this.id,
    required this.email,
    required this.fullname,
    required this.username,
    required this.role,
    required this.phone,
    required this.avatarUrl,
    required this.rewardPoints,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      rewardPoints: json['rewardPoints'] ?? 0,
    );
  }
}
