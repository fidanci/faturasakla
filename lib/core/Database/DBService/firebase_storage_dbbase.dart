import 'dart:io';

import 'package:faturasakla/core/Model/User.dart';

abstract class StorageBase {
  Future<String> uploadFile(
    User userID,
    File yuklenecekDosya,
    String kategori,
  );
}
