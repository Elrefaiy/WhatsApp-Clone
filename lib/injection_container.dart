import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_otp_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_phone_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_otp_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_phone_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_data.dart';
import 'core/network/network_info.dart';
import 'features/authentication/domain/usecases/submit_otp.dart';
import 'features/authentication/domain/usecases/submit_phone.dart';
import 'features/authentication/presentation/cubit/authentication_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
      submitPhoneUseCase: sl(),
      submitOTPUseCase: sl(),
    ),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit());

  // Use Cases

  // authentication
  sl.registerLazySingleton<SubmitPhoneUseCase>(
    () => SubmitPhoneUseCase(submitPhoneRepository: sl()),
  );
  sl.registerLazySingleton<SubmitOTPUseCase>(
    () => SubmitOTPUseCase(submitOTPRepository: sl()),
  );
  sl.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(updateUserRepository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<SubmitPhoneRepository>(
    () => SubmitPhoneRepositoryImpl(
      instance: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SubmitOTPRepository>(
    () => SubmitOTPRepositoryImpl(
      instance: sl(),
      networkInfo: sl(),
    ),
  );

  // Datasources

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<FirebaseAuthConsumer>(
    () => FirebaseAuthConsumerImpl(instance: sl()),
  );

  //Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
