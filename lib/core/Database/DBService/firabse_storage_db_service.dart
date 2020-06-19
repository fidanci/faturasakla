import 'dart:io';

import 'package:faturasakla/core/Database/DBService/firebase_storage_dbbase.dart';
import 'package:faturasakla/core/Model/makbuz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;
  Makbuz makbuz;

  @override
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async{
         _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child(makbuz.baslik.toString()+"--$fileType .png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;
      }
}
