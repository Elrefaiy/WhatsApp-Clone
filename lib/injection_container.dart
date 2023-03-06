import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/firebase/firebase_storage.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/get_current_user_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_otp_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_phone_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/update_image_repository_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/update_name_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/get_current_user_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_otp_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_phone_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_image_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_name_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/get_current_users.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_image.dart';
import 'core/network/network_info.dart';
import 'features/authentication/domain/usecases/submit_otp.dart';
import 'features/authentication/domain/usecases/submit_phone.dart';
import 'features/authentication/domain/usecases/update_name.dart';
import 'features/authentication/presentation/cubit/authentication_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory<AuthenticationCubit>(
    () => AuthenticationCubit(
      submitPhoneUseCase: sl(),
      submitOTPUseCase: sl(),
      getCurrentUserUseCase: sl(),
      updateUsernameUseCase: sl(),
      updateUserImageUseCase: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit());
  sl.registerFactory<SettingsCubit>(() => SettingsCubit());

  //! Use Cases

  // authentication
  sl.registerLazySingleton<SubmitPhoneUseCase>(
    () => SubmitPhoneUseCase(submitPhoneRepository: sl()),
  );
  sl.registerLazySingleton<SubmitOTPUseCase>(
    () => SubmitOTPUseCase(submitOTPRepository: sl()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getCurrentUserRepository: sl()),
  );
  sl.registerLazySingleton<UpdateUsernameUseCase>(
    () => UpdateUsernameUseCase(updateUsernameRepository: sl()),
  );
  sl.registerLazySingleton<UpdateUserImageUseCase>(
    () => UpdateUserImageUseCase(updateUserImageRepository: sl()),
  );

  //! Repositories
  sl.registerLazySingleton<SubmitPhoneRepository>(
    () => SubmitPhoneRepositoryImpl(
      instance: sl(),
      sharedPreferences: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SubmitOTPRepository>(
    () => SubmitOTPRepositoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<GetCurrentUserRepository>(
    () => GetCurrentUserRepositoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateUsernameRepository>(
    () => UpdateUsernameReposoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateUserImageRepository>(
    () => UpdateUserImageRepositoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
      storageInstance: sl(),
    ),
  );

  //! Datasources

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<FirebaseAuthConsumer>(
    () => FirebaseAuthConsumerImpl(instance: sl()),
  );
  sl.registerLazySingleton<FirebaseFirestoreConsumer>(
    () => FirebaseFirestoreConsumerImpl(instance: sl()),
  );
  sl.registerLazySingleton<FirebaseStorageConsumer>(
    () => FirebaseStorageConsumerImpl(instance: sl()),
  );

  //!Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
