import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faturasakla/core/Database/DBService/firebase_storage_dbbase.dart';
import 'package:faturasakla/core/Model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;
  Timestamp baslik = Timestamp.now();

  @override
  Future<String> uploadFile(
      User user, File yuklenecekDosya, String kategori) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(kategori)
        .child(user.uid)
        .child(baslik.toDate().toString() + ".png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
  }

  /*  @override
  Future<String> uploadFile(
      String userID,File yuklenecekDosya) async{
         _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child(baslik.toString()+"--$fileType .png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
      } */
}
