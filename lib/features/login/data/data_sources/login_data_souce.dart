import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experience_app/features/login/data/models/login_credentials_model.dart';
import 'package:experience_app/features/login/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSource {
  final FirebaseAuth _auth;

  LoginDataSource({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserModel> login(LoginRequestModel userLogin) async {
    try {
      if (_auth.currentUser == null) {
        final response = await _auth.signInWithEmailAndPassword(
          email: userLogin.email,
          password: userLogin.password,
        );
        print('el response es: $response');
        if (response.user?.uid != null) {
          return getUserInfo(response.user!.uid);
        }
      }
      _auth.signOut();
      throw Exception('El usuario ya está logueado');
    } on FirebaseAuthException catch (e) {
      print('Error en login: $e');
      throw Exception('Error en login: ${e.message}');
    }
  }

  Future<UserModel> getUserInfo(String uid) async {
    DocumentSnapshot usersCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
  
  if(usersCollection.exists) {
    print('User document data: ${usersCollection.data()}');
    final userData = UserModel.fromJson(usersCollection.data() as Map<String, dynamic>);
    print('User data: ${userData.name}, ${userData.email}, ${userData.role}');
    return userData;
  } else {
    print('No se encontró el usuario con UID: $uid');
    throw Exception('No se encontró el usuario con UID: $uid');
  }}

  Future<void> logout() async {
    await _auth.signOut();
  }
}
