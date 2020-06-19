import 'dart:async';
import 'dart:io';
import 'package:faturasakla/core/Database/Auth/authbase.dart';
import 'package:faturasakla/core/Database/Auth/firebase_auth_service.dart';
import 'package:faturasakla/core/Database/DBService/firestore_db_service.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';

enum AppMode { DEBUG, RELEASE }

class AuthRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  FirestoreDBService _firestoreDBService = FirestoreDBService();

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

  Future<bool> savetheelectricalreceipt(User user, File yuklenecekDosya) async {
    if (appMode == AppMode.RELEASE) {
      return _firestoreDBService.savetheelectricalreceipt(
          user, yuklenecekDosya);
    } else {
      return false;
    }
  }

  Future<List<Makbuz>> readtheelectricalreceipt(String userID) async {
    return await _firestoreDBService.readtheelectricalreceipt(userID);
  }

  Future<bool> savethewater(User user, File yuklenecekDosya) async {
    if (appMode == AppMode.RELEASE) {
      return _firestoreDBService.savethewater(user, yuklenecekDosya);
    } else {
      return false;
    }
  }

  Future<List<Makbuz>> readthewater(String userID) async{
    return await _firestoreDBService.readthewater(userID);
  }

  Future<bool> savethenaturelgas(User user, File yuklenecekDosya) async {
    if (appMode == AppMode.RELEASE) {
      return _firestoreDBService.savethenaturelgas(user, yuklenecekDosya);
    } else {
      return false;
    }
  }

  Future<List<Makbuz>> readthenaturelgas(String userID) async{
    return await _firestoreDBService.readthenaturelgas(userID);
  }

  Future<bool> savetheinternet(User user, File yuklenecekDosya) async {
    if (appMode == AppMode.RELEASE) {
      return _firestoreDBService.savetheinternet(user, yuklenecekDosya);
    } else {
      return false;
    }
  }

  Future<List<Makbuz>> readtheinternet(String userID) async{
    return await _firestoreDBService.readtheinternet(userID);
  }
}
