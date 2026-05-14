import 'package:experience_app/features/onboarding/domain/entities/user_interests_entity.dart';

abstract base class ExperiencePersonalitationState {
  final List<UserInterests>? interests;
  final List<UserInterests> selectedInterests;
  ExperiencePersonalitationState({this.interests = const [], this.selectedInterests = const []});
}

final class ExperiencePersonalitationInitialState extends ExperiencePersonalitationState {
  ExperiencePersonalitationInitialState() : super();
}

final class ExperiencePersonalitationLoadedState extends ExperiencePersonalitationState {
  ExperiencePersonalitationLoadedState({required super.interests});
}
