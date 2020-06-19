import 'dart:io';
import 'package:faturasakla/core/Database/Auth/authbase.dart';
import 'package:faturasakla/core/Database/Repository/auth_repository.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';

import 'dart:async';
import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  AuthRepository _authRepository = AuthRepository();
  String emailErrorMessage;
  String passwordErrorMessage;
  User _user;

  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<User> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _authRepository.currentUser();
      return _user;
    } catch (e) {
      print('UserViewModel CurrentUser error: ${e.toString()}');
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool _sonuc = await _authRepository.signOut();
      _user = null;
      return _sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki signout hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailAndPasswords(
      String email, String password) async {
    if (_emailAndPasswordControl(email, password)) {
      try {
        state = ViewState.Busy;
        _user = await _authRepository.createUserWithEmailAndPasswords(
            email, password);
        return _user;
      } finally {
        state = ViewState.Idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User> signInWithEmailAndPasswords(
      String email, String password) async {
    try {
      if (_emailAndPasswordControl(email, password)) {
        state = ViewState.Busy;
        _user =
            await _authRepository.signInWithEmailAndPasswords(email, password);
        return _user;
      } else {
        return null;
      }
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailAndPasswordControl(String email, String password) {
    var sonuc = true;
    if (password.length < 6) {
      passwordErrorMessage = "Şifreniz en az 6 karakter olmalıdır!";
      sonuc = false;
    } else {
      passwordErrorMessage = null;
    }
    if (!email.contains('@')) {
      emailErrorMessage = "Emial adresinizi kontrol ediniz!";
      sonuc = false;
    } else {
      emailErrorMessage = null;
    }

    return sonuc;
  }

  Future<bool> savetheelectricalreceipt(User user, File yuklenecekDosya) async {
    return await _authRepository.savetheelectricalreceipt(
        user, yuklenecekDosya);
  }

  Future<List<Makbuz>> readtheelectricalreceipt(String userID) async {
    return await _authRepository.readtheelectricalreceipt(userID);
  }

  Future<bool> savethewater(User user, File yuklenecekDosya) async {
    return _authRepository.savethewater(user, yuklenecekDosya);
  }

  Future<List<Makbuz>> readthewater(String userID) async {
    return await _authRepository.readthewater(userID);
  }

  Future<bool> savethenaturelgas(User user, File yuklenecekDosya) async {
    return _authRepository.savethenaturelgas(user, yuklenecekDosya);
  }

  Future<List<Makbuz>> readthenaturelgas(String userID) async {
    return await _authRepository.readthenaturelgas(userID);
  }

  Future<bool> savetheinternet(User user, File yuklenecekDosya) async {
    return _authRepository.savetheinternet(user, yuklenecekDosya);
  }

  Future<List<Makbuz>> readtheinternet(String userID) async {
    return await _authRepository.readtheinternet(userID);
  }
}
