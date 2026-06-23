
import 'package:experience_app/features/login/data/models/login_credentials_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSource {

final FirebaseAuth _auth;

LoginDataSource({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

Future<String> login(LoginRequestModel userLogin) async {
  try {
    if(_auth.currentUser == null) {
      final response = await _auth.signInWithEmailAndPassword(
        email: userLogin.email,
        password: userLogin.password,
      );
      print('el response es: $response');
      if (response.user?.uid != null) {
        return response.user!.uid;
      }
    }
    throw Exception('El usuario ya está logueado');
  } on FirebaseAuthException catch (e) {
    print('Error en login: $e');
    throw Exception('Error en login: ${e.message}');
  }
}

Future<void> logout() async {
  await _auth.signOut();
}



}