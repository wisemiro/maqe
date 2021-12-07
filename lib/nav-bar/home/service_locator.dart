import 'package:get_it/get_it.dart';
import 'package:maqe/nav-bar/home/repository/read_json.dart';

final GetIt locator = GetIt.instance;

void setup() {
 
  ///
  locator.registerLazySingleton<ReadJsonRepository>(() => ReadJsonRepository());
  // locator.registerLazySingleton<GlobalHiveService>(() => GlobalHiveService());
  /////
 
}
