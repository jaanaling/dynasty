import 'package:dynasty_dive/src/feature/home/repository/repository.dart';
import 'package:dynasty_dive/src/feature/lesson/repository/repository.dart';
import 'package:dynasty_dive/src/feature/notions/repository/repository.dart';
import 'package:dynasty_dive/src/feature/quizess/repository/test_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => HomeRepository());
  locator.registerLazySingleton(() => NotionRepository());
  locator.registerLazySingleton(() => LessonRepository());
  locator.registerLazySingleton(() => TestRepository());
}
