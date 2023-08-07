import 'package:demo_live_stream/exports/exports_path.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));

  // Register lazy singleton params video.
  sl.registerLazySingleton<ParamsLiveStream>(() => ParamsLiveStream());

  //  Socket IO.
  sl.registerLazySingleton(() => SocketIO());
}
