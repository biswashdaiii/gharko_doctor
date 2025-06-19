import 'package:get_it/get_it.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:gharko_doctor/features/authentication/data/repository/local_repository/user_local_repository.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/signin_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  await _initSplashModule();
  await _initUserModule();
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
    ()=>UserLocalDataSource(hiveServices: serviceLocator<HiveServices>())
  );

  //Repository
  serviceLocator.registerFactory(
    ()=>UserLocalRepository(userLocalDataSource: serviceLocator<UserLocalDataSource>(),)
  );

  //Usecase
  
  serviceLocator.registerFactory(
    ()=>UserRegisterUseCase(userRepository: serviceLocator<UserLocalRepository>()),
  );
  //Login Usecase
  serviceLocator.registerFactory(
    ()=>UserLoginUsecase(userRepository: serviceLocator<UserLocalRepository>()),
  );

  //ViewModel
  serviceLocator.registerFactory(
    ()=>SignupViewModel(serviceLocator<UserRegisterUseCase>(),
      
      ),
  );

  serviceLocator.registerFactory(
    ()=>LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}