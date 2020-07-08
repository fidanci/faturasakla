import 'package:faturasakla/core/Database/Auth/firebase_auth_service.dart';
import 'package:faturasakla/core/Database/DBService/firabse_storage_db_service.dart';
import 'package:faturasakla/core/Database/DBService/firestore_db_service.dart';
import 'package:faturasakla/core/Database/Repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance();

void setpu(){
locator.registerLazySingleton(() => FirebaseAuthService());
locator.registerLazySingleton(() => FirestoreDBService());
locator.registerLazySingleton(() => AuthRepository());
locator.registerLazySingleton(() => FirebaseStorageService());
}