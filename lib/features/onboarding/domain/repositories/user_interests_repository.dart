
import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';

abstract class UserInterestsRepository {
  Future<List<UserInterests>> getUserInterests();
  Future<void> saveUserInterests(List<UserInterests> interests);
}