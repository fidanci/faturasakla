import 'package:faturasakla/core/Database/DBService/firestore_db_Service.dart';
import 'package:faturasakla/core/Database/Repository/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'core/Database/Auth/firebase_auth_service.dart';

GetIt locator = GetIt.instance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => AuthRepository());
}
