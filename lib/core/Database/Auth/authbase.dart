import 'package:faturasakla/core/Model/User.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInWithEmailAndPasswords(String email, String password);
  Future<User> createUserWithEmailAndPasswords(String email, String password);
  Future<bool> signOut();
}
