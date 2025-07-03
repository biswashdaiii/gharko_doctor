import 'package:get_it/get_it.dart';
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';

// Local data source & repository
import 'package:gharko_doctor/features/authentication/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/remote_data_source/user_remote_datasource.dart';
import 'package:gharko_doctor/features/authentication/data/repository/local_repository/user_local_repository.dart';

// Remote data source & repository
import 'package:gharko_doctor/features/authentication/data/repository/remote_repository/user_remote_repository.dart';

// Use cases
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';

// ViewModels
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initSplashModule();
  await _initUserModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveServices());
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}

Future<void> _initUserModule() async {
  // Core ApiService for HTTP calls
  serviceLocator.registerLazySingleton(() => ApiService(Dio()));


  // Remote Data Source (calls backend API)
  serviceLocator.registerFactory(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Remote Repository (implements IUserRepository)
  serviceLocator.registerFactory(
    () => UserRemoteRepository(userRemoteDatasource: serviceLocator<UserRemoteDatasource>()),
  );

  // Local Data Source & Repository (optional, for caching)
  serviceLocator.registerFactory(
    () => UserLocalDataSource(hiveServices: serviceLocator<HiveServices>()),
  );

  serviceLocator.registerFactory(
    () => UserLocalRepository(userLocalDataSource: serviceLocator<UserLocalDataSource>()),
  );

  // UseCases — use RemoteRepository to actually call backend
  serviceLocator.registerFactory(
    () => UserRegisterUseCase(userRepository: serviceLocator<UserRemoteRepository>()),
  );

  serviceLocator.registerFactory(
    () => UserLoginUsecase(userRepository: serviceLocator<UserRemoteRepository>()),
  );

  // ViewModels
  serviceLocator.registerLazySingleton(
    () => RegisterViewModel(registerUseCase: serviceLocator<UserRegisterUseCase>()),
  );

  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}
