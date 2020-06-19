import 'dart:io';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';


abstract class DBBase {
  Future<bool> saveUser(User user);
  Future<User> readUser(String userID);
  // Elektrik
  Future<bool> savetheelectricalreceipt(User user,File yuklenecekDosya);
  Future<List<Makbuz>> readtheelectricalreceipt(String userID);
  // Su
  Future<bool> savethewater(User user,File yuklenecekDosya);
  Future<List<Makbuz>> readthewater(String userID);
  //Doğalgaz
   Future<bool> savethenaturelgas(User user,File yuklenecekDosya);
  Future<List<Makbuz>> readthenaturelgas(String userID);
  //İnternet
  Future<bool> savetheinternet(User user,File yuklenecekDosya);
  Future<List<Makbuz>> readtheinternet(String userID);
} 