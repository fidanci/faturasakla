import 'package:flutter/material.dart';

class User {
  final String uid;
  String email;

  User({
    @required this.uid,
    @required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        email = map['email'];
}
