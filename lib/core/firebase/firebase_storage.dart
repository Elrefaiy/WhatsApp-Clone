import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageConsumer {
  Future<dynamic> upload({
    required String path,
    required File file,
    required Function function,
  });
}

class FirebaseStorageConsumerImpl implements FirebaseStorageConsumer {
  final FirebaseStorage instance;
  FirebaseStorageConsumerImpl({required this.instance});

  @override
  Future upload({
    required String path,
    required File file,
    required Function function,
  }) async {
    return await instance.ref().child(path).putFile(file).then((value) {
      value.ref.getDownloadURL().then((value) => function(value));
    });
  }
}
