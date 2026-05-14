
class UserInterestsModel {
  final int id;
  final String name;

  UserInterestsModel({required this.id, required this.name});

  factory UserInterestsModel.fromJson(Map<String, dynamic> json) {
    return UserInterestsModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
