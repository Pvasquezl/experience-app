class UserModel {
  final String userName;
  final String name;
  final String email;
  final String role;

  const UserModel({
    required this.userName,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['user_name'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}