class LoginResponseModel {
  final String token;
  final String username;
  final String email;

  LoginResponseModel({
    required this.token,
    required this.username,
    required this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return LoginResponseModel(
      token: json['token'] ?? '',
      username: user['username'] ?? '',
      email: user['email'] ?? '',
    );
  }
}
