import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faturasakla/core/Database/DBService/DBBase.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreDBService implements DBBase {
  Firestore _firebaseDB = Firestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage();
  StorageReference _storageReference;

  @override
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

  @override
  Future<User> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection('User').document(userID).get();

    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data;
    User _okunanUserNesnesi = User.fromMap(_okunanUserBilgileriMap);
    return _okunanUserNesnesi;
  }

  @override
  Future<bool> savetheelectricalreceipt(User user, File yuklenecekDosya) async {
    Timestamp baslik = Timestamp.now();
    var _makbuzId = _firebaseDB.collection("Elektrik").document().documentID;
    _storageReference = _firebaseStorage
        .ref()
        .child('Elektrik')
        .child(user.uid)
        .child(baslik.toDate().toString() + ".png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    await _firebaseDB
        .collection('Elektrik')
        .document(user.uid)
        .collection('makbuz')
        .document(_makbuzId)
        .setData({
      'user': user.uid,
      'baslik': baslik,
      'photoURL': url,
    });
 
    return true;
  }

  @override
  Future<List<Makbuz>> readtheelectricalreceipt(String userID) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection('Elektrik')
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

    return tumMakbuzlar;
  }

  @override
  Future<bool> savethewater(User user, File yuklenecekDosya) async {
    Timestamp baslik = Timestamp.now();
    var _makbuzId = _firebaseDB.collection("Su").document().documentID;
    _storageReference = _firebaseStorage
        .ref()
        .child('Su')
        .child(user.uid)
        .child(baslik.toDate().toString() + ".png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    await _firebaseDB
        .collection('Su')
        .document(user.uid)
        .collection('makbuz')
        .document(_makbuzId)
        .setData({
      'user': user.uid,
      'baslik': baslik,
      'photoURL': url,
    });

    return true;
  }

  @override
  Future<List<Makbuz>> readthewater(String userID) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection('Su')
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

    return tumMakbuzlar;
  }

  @override
  Future<bool> savethenaturelgas(User user, File yuklenecekDosya) async {
    Timestamp baslik = Timestamp.now();
    var _makbuzId = _firebaseDB.collection("DogalGaz").document().documentID;
    _storageReference = _firebaseStorage
        .ref()
        .child('DogalGaz')
        .child(user.uid)
        .child(baslik.toDate().toString() + ".png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    await _firebaseDB
        .collection('DogalGaz')
        .document(user.uid)
        .collection('makbuz')
        .document(_makbuzId)
        .setData({
      'user': user.uid,
      'baslik': baslik,
      'photoURL': url,
    });
 
    return true;
  }

  @override
  Future<List<Makbuz>> readthenaturelgas(String userID) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection('DogalGaz')
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

    return tumMakbuzlar;
  }

  @override
  Future<bool> savetheinternet(User user, File yuklenecekDosya) async {
    Timestamp baslik = Timestamp.now();
    var _makbuzId = _firebaseDB.collection("Internet").document().documentID;
    _storageReference = _firebaseStorage
        .ref()
        .child('Internet')
        .child(user.uid)
        .child(baslik.toDate().toString() + ".png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    await _firebaseDB
        .collection('Internet')
        .document(user.uid)
        .collection('makbuz')
        .document(_makbuzId)
        .setData({
      'user': user.uid,
      'baslik': baslik,
      'photoURL': url,
    });

    return true;
  }

  @override
  Future<List<Makbuz>> readtheinternet(String userID) async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection('Internet')
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

    return tumMakbuzlar;
  }
}
