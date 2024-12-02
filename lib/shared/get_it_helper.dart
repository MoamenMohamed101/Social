import 'package:get_it/get_it.dart';
import 'package:social/shared/network/local/cache_helper.dart';

final getIt = GetIt.instance;

Future<void> setup() async{
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

// Alternatively you could write it if you don't like global variables
//   GetIt.I.registerSingleton<CacheHelper>(CacheHelper());
}
