import 'package:faturasakla/core/Database/Auth/authbase.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (e) {
      print('Error current user' + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print('Error SignOut' + e.toString());
      return false;
    }
  }

  @override
  Future<User> createUserWithEmailAndPasswords(
      String email, String password) async {
    AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user);
  }

  @override
  Future<User> signInWithEmailAndPasswords(
      String email, String password) async {
    AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(sonuc.user);
  }
}
