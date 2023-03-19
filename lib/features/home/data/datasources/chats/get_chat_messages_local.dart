import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/features/home/data/models/message_model.dart';

abstract class GetChatMessagesLocalDataSource {
  Stream<List<MessageModel>> getChatMessages(String receiverId);
  Future<bool> cacheMessages(
      String receiverId, Stream<List<MessageModel>> messages);
}

class GetChatMessagesLocalDataImpl implements GetChatMessagesLocalDataSource {
  final SharedPreferences sharedPreferences;

  GetChatMessagesLocalDataImpl({required this.sharedPreferences});
  @override
  Stream<List<MessageModel>> getChatMessages(String receiverId) {
    // final encodedJson = sharedPreferences.getString(receiverId);
    // if (encodedJson != null) {
    //   Stream<List<MessageModel>> messages ;
    //   List decodedJson = json.decode(encodedJson);
    //   for (var element in decodedJson) {
    //     messages.(MessageModel.fromJson(element));
    //   }
    //   return messages;
    // } else {
    //   throw const CacheException();
    // }
    throw Exception();
  }

  @override
  Future<bool> cacheMessages(
    String receiverId,
    Stream<List<MessageModel>> messages,
  ) async {
    return await sharedPreferences.setString(receiverId, json.encode(messages));
  }
}
