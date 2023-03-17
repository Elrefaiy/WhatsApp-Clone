import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/utils/app_strings.dart';
import 'package:whatsapp_clone/features/home/data/models/user_model.dart';

abstract class GetAllUsersLocalDataSource {
  List<UserModel> getAllUsers();
  Future<bool> cacheUsers(List<UserModel> contacts);
}

class GetAllUsersLocalDataSourceImpl implements GetAllUsersLocalDataSource {
  final SharedPreferences sharedPreferences;

  GetAllUsersLocalDataSourceImpl({required this.sharedPreferences});
  @override
  List<UserModel> getAllUsers() {
    final source = sharedPreferences.getString(AppStrings.allContacts);
    if (source != null) {
      final encodedJson = json.decode(source);
      List<UserModel> allUsers = [];
      for (var element in encodedJson) {
        allUsers.add(UserModel.fromJson(element));
      }
      return allUsers;
    } else {
      throw const CacheException();
    }
  }

  @override
  Future<bool> cacheUsers(List<UserModel> contacts) async {
    final response = await sharedPreferences.setString(
      AppStrings.allContacts,
      json.encode(contacts),
    );
    return response;
  }
}
