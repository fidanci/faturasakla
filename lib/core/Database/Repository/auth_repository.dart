import 'dart:async';
import 'dart:io';
import 'package:faturasakla/core/Database/Auth/authbase.dart';
import 'package:faturasakla/core/Database/Auth/firebase_auth_service.dart';
import 'package:faturasakla/core/Database/DBService/firabse_storage_db_service.dart';
import 'package:faturasakla/core/Database/DBService/firestore_db_service.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';

enum AppMode { DEBUG, RELEASE }

class AuthRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  FirestoreDBService _firestoreDBService = FirestoreDBService();
  FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<User> currentUser() async {
    if (appMode == AppMode.RELEASE) {
      User _user = await _firebaseAuthService.currentUser();
      return await _firestoreDBService.readUser(_user.uid);
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.RELEASE) {
      return await _firebaseAuthService.signOut();
    } else {
      return false;
    }
  }

  @override
  Future<User> createUserWithEmailAndPasswords(
      String email, String password) async {
    if (appMode == AppMode.RELEASE) {
      User _user = await _firebaseAuthService.createUserWithEmailAndPasswords(
          email, password);
      bool _sonuc = await _firestoreDBService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreDBService.readUser(_user.uid);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User> signInWithEmailAndPasswords(
      String email, String password) async {
    User _user =
        await _firebaseAuthService.signInWithEmailAndPasswords(email, password);
    return await _firestoreDBService.readUser(_user.uid);
  }

  Future<String> uploadFile(
      User user, File yuklenecekDosya, String kategori) async {
    return await _firebaseStorageService.uploadFile(
      user,
      yuklenecekDosya,
      kategori,
    );
  }

  Future<bool> makbuzKaydet(
      Makbuz makbuz, String userID, String koleksiyon) async {
    return await _firestoreDBService.makbuzKaydet(makbuz, userID, koleksiyon);
  }

  Future<List<Makbuz>> makbuzOku(String userID, String kategori) async {
    return await _firestoreDBService.makbuzOku(userID, kategori);
  }

  Future<String> makbuzID(String userID, String kategori) async {
    return await _firestoreDBService.makbuzID(userID, kategori);
  }
}
