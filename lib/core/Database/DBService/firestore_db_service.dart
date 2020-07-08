import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';
import 'package:flutter/cupertino.dart';

class FirestoreDBService with ChangeNotifier {
  Firestore _firebaseDB = Firestore.instance;

  Future<bool> saveUser(User user) async {
    await _firebaseDB
        .collection('User')
        .document(user.uid)
        .setData(user.toMap());

    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.uid}").get();

    Map _okunanUserBilgileriMap = _okunanUser.data;
    User.fromMap(_okunanUserBilgileriMap);

    return true;
  }

  Future<User> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection('User').document(userID).get();

    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data;
    User _okunanUserNesnesi = User.fromMap(_okunanUserBilgileriMap);
    return _okunanUserNesnesi;
  }

  Future<bool> makbuzKaydet(
      Makbuz makbuz, String userID, String koleksiyon) async {
    var _makbuzId = _firebaseDB.collection(koleksiyon).document().documentID;
    var _kaydedilecekMakbuz = makbuz.toMap();
    await _firebaseDB
        .collection(koleksiyon)
        .document(userID)
        .collection('makbuz')
        .document(_makbuzId)
        .setData(_kaydedilecekMakbuz);
    notifyListeners();
    return true;
  }

  Future<List<Makbuz>> makbuzOku(String userID, String kategori) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection(kategori)
        .document(userID)
        .collection('makbuz')
        .where('user', isEqualTo: userID)
        .orderBy('baslik', descending: true)
        .getDocuments();
    List<Makbuz> tumMakbuzlar = [];
    for (DocumentSnapshot snapshot in querySnapshot.documents) {
      Makbuz _makbuz = Makbuz.fromMap(snapshot.data);
      tumMakbuzlar.add(_makbuz);
    }
    notifyListeners();
    return tumMakbuzlar;
  }

  Future<String> makbuzID(String userID, String kategori) async {
    var querySnapshot = _firebaseDB
        .collection(kategori)
        .document(userID)
        .collection('makbuz')
        .document()
        .documentID;

    return querySnapshot;
  }
}
