import 'package:cloud_firestore/cloud_firestore.dart';

class Makbuz {
  final String user;
  final DateTime baslik;
  final String photoURL;

  Makbuz(
    this.user,
    this.baslik,
    this.photoURL,
  );

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'baslik': baslik ?? FieldValue.serverTimestamp(),
      'photoURL': photoURL,
    };
  }

  Makbuz.fromMap(Map<String, dynamic> map)
      : user = map['user'],
        baslik = (map['baslik'] as Timestamp).toDate(),
        photoURL = map['photoURL'];
}
