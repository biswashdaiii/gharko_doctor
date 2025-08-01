import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:gharko_doctor/app/sharedPref/token_helper.dart';
import 'package:gharko_doctor/features/myappointments/data/datasource/myappointments_remotedatasource.dart';
import 'package:gharko_doctor/features/myappointments/data/repository/myapppointment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';

// User Auth imports
import 'package:gharko_doctor/features/authentication/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/remote_data_source/user_remote_datasource.dart';
import 'package:gharko_doctor/features/authentication/data/repository/local_repository/user_local_repository.dart';
import 'package:gharko_doctor/features/authentication/data/repository/remote_repository/user_remote_repository.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';

// Booking imports
import 'package:gharko_doctor/features/booking/data/data_source/appointment_remote_datasource.dart';
import 'package:gharko_doctor/features/booking/data/repository/appointment_repository_impl.dart';
import 'package:gharko_doctor/features/booking/domain/repository/appointment_repository.dart';
import 'package:gharko_doctor/features/booking/domain/usecase/book_appointment_usecase.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_bloc.dart';

// Dashboard/Doctor imports
import 'package:gharko_doctor/features/dashboard/data/data_source/doctor_remote_datasource.dart';
import 'package:gharko_doctor/features/dashboard/data/repository/doctor_remote_repository.dart';
import 'package:gharko_doctor/features/dashboard/domain/repository/doctor_repository.dart';
import 'package:gharko_doctor/features/dashboard/domain/usecase/get_all_doctor_usecase.dart';
import 'package:gharko_doctor/features/dashboard/domain/usecase/get_doctor_byspeciality_usecase.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view_model/doctor_bloc.dart';

// Profile imports
import 'package:gharko_doctor/features/profile/data/datasource/profile_remotedatasource.dart';
import 'package:gharko_doctor/features/profile/data/repository/profile_repositoryImpl.dart';
import 'package:gharko_doctor/features/profile/domain/reposittory/profile_repository.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/getprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/updateprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_bloc.dart';

// Splash
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

// MyAppointments imports
import 'package:gharko_doctor/features/myappointments/data/datasource/abstractRemotedatasource.dart';
import 'package:gharko_doctor/features/myappointments/domain/repository/myappointment_Irepository.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/cancel_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/get_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // Register SharedPreferences instance
  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Register TokenSharedPrefs once (uses SharedPreferences)
  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(sharedPreferences: serviceLocator<SharedPreferences>()),
  );
  // Register TokenHelper
serviceLocator.registerLazySingleton<TokenHelper>(
  () => TokenHelper(serviceLocator<TokenSharedPrefs>()),
);

  // Register http.Client once for http requests
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // Register ApiService once with Dio
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio()));

  // Register HiveServices once
  serviceLocator.registerLazySingleton<HiveServices>(() => HiveServices());

  await _initSplashModule();
  await _initUserModule();
  await _initDoctorModule();
  await _initProfileModule();
  await _initAppointmentModule();
  await _initMyAppointmentsModule();  // <--- Added this line
}

// Splash Module
Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}

// User Module
Future<void> _initUserModule() async {
  serviceLocator.registerFactory<UserRemoteDatasource>(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSource(hiveServices: serviceLocator<HiveServices>()),
  );

  serviceLocator.registerFactory<UserRemoteRepository>(
    () => UserRemoteRepository(userRemoteDatasource: serviceLocator<UserRemoteDatasource>()),
  );

  serviceLocator.registerFactory<UserLocalRepository>(
    () => UserLocalRepository(userLocalDataSource: serviceLocator<UserLocalDataSource>()),
  );

  serviceLocator.registerFactory<UserRegisterUseCase>(
    () => UserRegisterUseCase(userRepository: serviceLocator<UserRemoteRepository>()),
  );

  serviceLocator.registerFactory<UserLoginUsecase>(
    () => UserLoginUsecase(userRepository: serviceLocator<UserRemoteRepository>()),
  );

  serviceLocator.registerLazySingleton<RegisterViewModel>(
    () => RegisterViewModel(registerUseCase: serviceLocator<UserRegisterUseCase>()),
  );

  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

// Doctor Module
Future<void> _initDoctorModule() async {
  serviceLocator.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<IDoctorRepository>(
    () => DoctorRemoteRepository(
      doctorRemoteDatasource: serviceLocator<DoctorRemoteDataSource>(),
    ),
  );

  serviceLocator.registerLazySingleton<GetAllDoctorsUseCase>(
    () => GetAllDoctorsUseCase(repository: serviceLocator<IDoctorRepository>()),
  );

  serviceLocator.registerLazySingleton<GetDoctorsBySpecialityUseCase>(
    () => GetDoctorsBySpecialityUseCase(repository: serviceLocator<IDoctorRepository>()),
  );

  serviceLocator.registerFactory<DoctorBloc>(
    () => DoctorBloc(
      getAllDoctorsUseCase: serviceLocator<GetAllDoctorsUseCase>(),
      getDoctorsBySpecialityUseCase: serviceLocator<GetDoctorsBySpecialityUseCase>(),
    ),
  );
}

// Profile Module
Future<void> _initProfileModule() async {
  serviceLocator.registerLazySingleton<IUserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerLazySingleton<IUserProfileRepository>(
    () => UserProfileRepositoryImpl(
      remoteDataSource: serviceLocator<IUserProfileRemoteDataSource>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(serviceLocator<IUserProfileRepository>()),
  );

  serviceLocator.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(serviceLocator<IUserProfileRepository>()),
  );

  serviceLocator.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: serviceLocator<GetProfileUseCase>(),
      updateProfileUseCase: serviceLocator<UpdateProfileUseCase>(),
    ),
  );
}

// Appointment Module
Future<void> _initAppointmentModule() async {
  serviceLocator.registerLazySingleton<AppointmentRemoteDataSourceImpl>(
    () => AppointmentRemoteDataSourceImpl(
      client: serviceLocator<http.Client>(),
      apiService: serviceLocator<ApiService>(),
    ),
  );

  serviceLocator.registerLazySingleton<IAppointmentRepository>(
    () => AppointmentRepositoryImpl(
      remoteDataSource: serviceLocator<AppointmentRemoteDataSourceImpl>(),
    ),
  );

  serviceLocator.registerLazySingleton<BookAppointmentUseCase>(
    () => BookAppointmentUseCase(
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
      repository: serviceLocator<IAppointmentRepository>(),
    ),
  );

  serviceLocator.registerFactory<AppointmentBloc>(
    () => AppointmentBloc(
      bookAppointmentUseCase: serviceLocator<BookAppointmentUseCase>(),
    ),
  );
}

// MyAppointments Module
Future<void> _initMyAppointmentsModule() async {
  // Remote data source
  serviceLocator.registerLazySingleton<MyAppointmentRemoteDataSource>(
    () => MyAppointmentRemoteDataSourceImpl(client: serviceLocator<http.Client>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<IMyAppointmentRepository>(
    () => MyAppointmentRepositoryImpl(
      remoteDataSource: serviceLocator<MyAppointmentRemoteDataSource>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton<GetUserAppointmentsUseCase>(
    () => GetUserAppointmentsUseCase(
      repository: serviceLocator<IMyAppointmentRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerLazySingleton<CancelUserAppointmentUseCase>(
    () => CancelUserAppointmentUseCase(
      repository: serviceLocator<IMyAppointmentRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Bloc
  serviceLocator.registerFactory<MyAppointmentsBloc>(
    () => MyAppointmentsBloc(
      getUserAppointmentsUseCase: serviceLocator<GetUserAppointmentsUseCase>(),
      cancelUserAppointmentUseCase: serviceLocator<CancelUserAppointmentUseCase>(),
    ),
  );
}
