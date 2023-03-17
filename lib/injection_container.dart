import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/firebase/firebase_storage.dart';
import 'package:whatsapp_clone/features/authentication/data/datasources/get_current_user_local.dart';
import 'package:whatsapp_clone/features/authentication/data/datasources/get_current_user_remote.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/get_current_user_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_otp_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/submit_phone_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/update_about_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/update_image_repository_impl.dart';
import 'package:whatsapp_clone/features/authentication/data/repositories/update_name_repo_impl.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/get_current_user_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_otp_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/submit_phone_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_about_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_image_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_name_repo.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/get_current_users.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_about.dart';
import 'package:whatsapp_clone/features/authentication/domain/usecases/update_image.dart';
import 'package:whatsapp_clone/features/home/data/datasources/get_all_users_local.dart';
import 'package:whatsapp_clone/features/home/data/datasources/get_all_users_remote.dart';
import 'package:whatsapp_clone/features/home/data/repositories/chats/get_all_users_repo_impl.dart';
import 'package:whatsapp_clone/features/home/data/repositories/chats/send_text_message_repo_impl.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/get_all_users_repo.dart';
import 'package:whatsapp_clone/features/home/domain/repositories/chats/send_text_message_repo.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/get_all_users.dart';
import 'package:whatsapp_clone/features/home/domain/usecases/chats/send_text_message.dart';
import 'package:whatsapp_clone/features/settings/data/repositories/logout_repo_impl.dart';
import 'package:whatsapp_clone/features/settings/domain/repositories/logout_repository.dart';
import 'package:whatsapp_clone/features/settings/domain/usecases/logout.dart';
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
      updateAboutUseCase: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      getAllUsersUseCase: sl(),
      sendTextMessageUseCase: sl(),
    ),
  );

  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      logoutUseCase: sl(),
      sharedPreferences: sl(),
    ),
  );

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
  sl.registerLazySingleton<UpdateAboutUseCase>(
    () => UpdateAboutUseCase(updateAboutRepository: sl()),
  );

  // home
  sl.registerLazySingleton<GetAllUsersUseCase>(
    () => GetAllUsersUseCase(getAllUsersRepository: sl()),
  );
  sl.registerLazySingleton<SendTextMessageUseCase>(
    () => SendTextMessageUseCase(sendTextMessageRepository: sl()),
  );

  // settings
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(logoutRepository: sl()),
  );

  //! Repositories

  // authentication
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
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateUsernameRepository>(
    () => UpdateUsernameReposoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UpdateAboutRepository>(
    () => UpdateAboutReposoryImpl(
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

  // home
  sl.registerLazySingleton<GetAllUsersRepository>(
    () => GetAllUsersRepositroyImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SendTextMessageRepository>(
    () => SendTextMessageRepositoryImpl(
      authInstance: sl(),
      storeInstance: sl(),
      networkInfo: sl(),
    ),
  );

  // settings
  sl.registerLazySingleton<LogoutRepository>(
    () => LogoutRepositoryImpl(
      authInstance: sl(),
      networkInfo: sl(),
      sharedPreferences: sl(),
    ),
  );

  //! Datasources

  // authentication
  sl.registerLazySingleton<GetCurrentUserRemoteDataSource>(
    () => GetCurrentUserRemoteDataSourceImpl(
      authInstance: sl(),
      storeInstance: sl(),
    ),
  );
  sl.registerLazySingleton<GetCurrentUserLocalDataSource>(
    () => GetCurrentUserLocalDataImpl(
      sharedPreferences: sl(),
    ),
  );

  // home
  sl.registerLazySingleton<GetAllUsersRemoteDataSource>(
    () => GetAllUsersRemoteDataSourceImpl(
      instance: sl(),
    ),
  );
  sl.registerLazySingleton<GetAllUsersLocalDataSource>(
    () => GetAllUsersLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
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
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
