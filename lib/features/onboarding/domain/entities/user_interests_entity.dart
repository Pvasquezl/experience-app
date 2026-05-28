import 'package:experience_app/features/onboarding/data/models/user_interests_model.dart';

class UserInterests {
  final int id;
  final String name;

  UserInterests({
    required this.id,
    required this.name,
  });

  factory UserInterests.fromModel(UserInterestsModel model) {
    return UserInterests(
      id: model.id,
      name: model.name,
    );
  }
  UserInterestsModel toModel() {
    return UserInterestsModel(
      id: id,
      name: name,
    );
  }
}