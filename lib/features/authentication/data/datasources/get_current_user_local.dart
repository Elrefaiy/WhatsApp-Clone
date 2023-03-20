import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/user_model.dart';

abstract class GetCurrentUserLocalDataSource {
  UserModel getCurrentUser();
  Future<bool> cacheCurrentUser(UserModel user);
}

class GetCurrentUserLocalDataImpl implements GetCurrentUserLocalDataSource {
  final SharedPreferences sharedPreferences;
  GetCurrentUserLocalDataImpl({
    required this.sharedPreferences,
  });

  @override
  UserModel getCurrentUser() {
    final jsonString = sharedPreferences.getString(AppStrings.currentUser);
    if (jsonString != null) {
      final user = UserModel.fromJson(json.decode(jsonString));
      return user;
    } else {
      throw const CacheException();
    }
  }

  @override
  Future<bool> cacheCurrentUser(UserModel user) async {
    return await sharedPreferences.setString(
      AppStrings.currentUser,
      json.encode(user),
    );
  }
}
