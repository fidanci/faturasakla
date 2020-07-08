import 'package:faturasakla/core/Model/User.dart';
import 'package:faturasakla/core/Model/makbuz.dart';

abstract class DBBase {
  Future<bool> saveUser(User user);
  Future<User> readUser(String userID);
  Future<bool> mkabuzKaydet(Makbuz makbuz, String userID, String koleksiyon);
  Future<List<Makbuz>> makbuzOku(String userID, String kategori);
  Future<String> makbuzID(String userID, String kategori);
}
