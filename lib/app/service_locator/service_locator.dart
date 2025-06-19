import 'package:get_it/get_it.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initSplashModule();
  await _initUserModule();
  await _initLoginModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveServices());
}
Future _initSplashModule() async {
  // Register Splash ViewModel
  serviceLocator.registerFactory<SplashViewModel>(() => SplashViewModel());
}
Future<void> _initUserModule()async{
  serviceLocator.registerFactory(
    ()=>UserLocalDataSource(hiveservices: serviceLocator<HiveServices>())
  );
  serviceLocator.registerFactory(
    ()=>UserLocalRepositoryImpl(userLocalDataSource: serviceLocator<UserLocalDataSource>(),)
  );
  serviceLocator.registerFactory(
    ()=>UserRegisterUseCase(userRepository: serviceLocator<UserLocalRepositoryImpl>()),
  );
  serviceLocator.registerFactory(
    ()=>LoginViewModel(),
  );
}