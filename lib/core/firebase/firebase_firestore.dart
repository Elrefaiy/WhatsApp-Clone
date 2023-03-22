import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/authentication/data/models/user_model.dart';
import '../../features/home/data/models/contact_model.dart';
import '../../features/home/data/models/message_model.dart';

abstract class FirebaseFirestoreConsumer {
  Future<bool> setUser({
    required String uId,
    required String phone,
  });

  Future<Map<String, dynamic>> getUser({
    required String uId,
  });

  Future<List<Map<String, dynamic>>> getAllUsers();

  Stream<List<MessageModel>> getChatMessages({
    required String uId,
    required String recieverId,
  });

  Future<dynamic> setContact({
    required String uId,
    required String reciverId,
    required Map<String, dynamic> body,
  });

  Future<List<ContactModel>> getAllChats({
    required String uId,
  });

  Future<dynamic> updateUserData({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  });

  Future<dynamic> updateContactData({
    required String uId,
    required String reciverId,
    required Map<String, dynamic> body,
  });

  Future<dynamic> addMessage({
    required String collection1,
    required String doc1,
    required String collection2,
    required String doc2,
    required String collection3,
    required Map<String, dynamic> body,
  });
}

class FirebaseFirestoreConsumerImpl implements FirebaseFirestoreConsumer {
  final FirebaseFirestore instance;
  FirebaseFirestoreConsumerImpl({required this.instance});

  @override
  Future addMessage({
    required String collection1,
    required String doc1,
    required String collection2,
    required String doc2,
    required String collection3,
    required Map<String, dynamic> body,
  }) async {
    await instance
        .collection(collection1)
        .doc(doc1)
        .collection(collection2)
        .doc(doc2)
        .collection(collection3)
        .add(body)
        .then(
      (value) {
        if (doc1 != doc2) {
          instance
              .collection(collection1)
              .doc(doc2)
              .collection(collection2)
              .doc(doc1)
              .collection(collection3)
              .add(body);
        }
      },
    );
  }

  @override
  Future updateUserData({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  }) async {
    await instance.collection(collection).doc(doc).update(body);
  }

  @override
  Future updateContactData({
    required String uId,
    required String reciverId,
    required Map<String, dynamic> body,
  }) async {
    await instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(reciverId)
        .update(body);
  }

  @override
  Future<Map<String, dynamic>> getUser({required String uId}) async {
    return await instance.collection('users').doc(uId).get().then(
          (value) => Future.value(value.data()),
        );
  }

  @override
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final List<Map<String, dynamic>> users = [];
    await instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        users.add(
          element.data(),
        );
      }
    });
    return users;
  }

  @override
  Stream<List<MessageModel>> getChatMessages({
    required String uId,
    required String recieverId,
  }) {
    return instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];

      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      return messages;
    });
  }

  @override
  Future<bool> setUser({
    required String uId,
    required String phone,
  }) async {
    final users = await getAllUsers();
    for (var element in users) {
      if (element['uId'] == uId) {
        return false;
      }
    }
    await instance.collection('users').doc(uId).set(
          UserModel(
            name: 'User Name',
            phone: phone,
            about: 'Hello, I am using Whatsapp',
            image: 'image',
            uId: uId,
          ).toJson(),
        );
    return true;
  }

  @override
  Future<List<ContactModel>> getAllChats({
    required String uId,
  }) async {
    List<ContactModel> allContacts = [];
    await instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .get()
        .then((value) {
      for (var element in value.docs) {
        allContacts.add(ContactModel.fromJson(element.data()));
      }
    });
    return allContacts;
  }

  @override
  Future setContact({
    required String uId,
    required String reciverId,
    required Map<String, dynamic> body,
  }) async {
    return await instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(reciverId)
        .set(body);
  }
}
