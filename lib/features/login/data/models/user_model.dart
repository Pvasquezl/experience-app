class UserModel {
  final String uid;
  final String nombre;
  final String email;
  final String rol;

  const UserModel({
    required this.uid,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      nombre: json['nombre'],
      email: json['email'],
      rol: json['rol'],
    );
  }
}