
import 'package:experience_app/features/onboarding/data/models/user_interests_model.dart';

class InterestsDataSource {

    Future<List<UserInterestsModel>> getUserInterests() async {
        await Future.delayed(const Duration(seconds: 1)); 
        const data = [
            {
                'id': 1,
                'name': 'User Interface',
            },
            {
                'id': 2,
                'name': 'User Experience',
            },
            {
                'id': 3,
                'name': 'User Research',
            },
            {
                'id': 4,
                'name': 'UX Writing',
            },
            {
                'id': 5,
                'name': 'User Testing',
            },
            {
                'id': 6,
                'name': 'Service Design',
            },
            {
                'id': 7,
                'name': 'Strategy',
            },
            {
                'id': 8,
                'name': 'Design Systems',
            },
            {
                'id': 9,
                'name': 'Accessibility',
            },
            {
                'id': 10,
                'name': 'Motion Design',
            }
        ];
        return data.map((json) => UserInterestsModel.fromJson(json)).toList();
    }

    Future<void> saveUserInterests(List<UserInterestsModel> interests) async {
        await Future.delayed(const Duration(seconds: 1)); 
        final userInterests = interests.map((interest) => UserInterestsModel(
            id: interest.id,
            name: interest.name,
        ).toJson()).toList();
        print('Intereses guardados: $userInterests');
    }
}