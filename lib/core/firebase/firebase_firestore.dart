import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseFirestoreConsumer {
  Future<dynamic> get({
    required String collection1,
    String? doc1,
    String? collection2,
    String? doc2,
    String? collection3,
  });
  Future<dynamic> set({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  });
  Future<dynamic> update({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  });
  Future<dynamic> add({
    required String collection1,
    required String doc1,
    required String collection2,
    String? doc2,
    String? collection3,
    required Map<String, dynamic> body,
  });
}

class FirebaseFirestoreConsumerImpl implements FirebaseFirestoreConsumer {
  final FirebaseFirestore instance;

  FirebaseFirestoreConsumerImpl({required this.instance});
  @override
  Future add({
    required String collection1,
    required String doc1,
    required String collection2,
    String? doc2,
    String? collection3,
    required Map<String, dynamic> body,
  }) async {
    if (collection3 != null) {
      await instance
          .collection(collection1)
          .doc(doc1)
          .collection(collection2)
          .doc(doc2)
          .collection(collection3)
          .add(body);
    } else {
      await instance
          .collection(collection1)
          .doc(doc1)
          .collection(collection2)
          .add(body);
    }
  }

  @override
  Future<dynamic> get({
    required String collection1,
    String? doc1,
    String? collection2,
    String? doc2,
    String? collection3,
  }) async {
    if (doc1 == null) {
      await instance.collection(collection1).get();
    } else if (collection2 == null) {
      await instance
          .collection(collection1)
          .doc(doc1)
          .get()
          .then((value) => value.data());
    } else if (doc2 == null) {
      await instance
          .collection(collection1)
          .doc(doc1)
          .collection(collection2)
          .get();
    } else if (collection3 == null) {
      await instance
          .collection(collection1)
          .doc(doc1)
          .collection(collection2)
          .doc(doc2)
          .get()
          .then(
        (value) {
          return value.data();
        },
      );
    } else {
      await instance
          .collection(collection1)
          .doc(doc1)
          .collection(collection2)
          .doc(doc2)
          .collection(collection3)
          .get();
    }
  }

  @override
  Future set({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  }) async {
    await instance.collection(collection).doc(doc).set(body);
  }

  @override
  Future update({
    required String collection,
    required String doc,
    required Map<String, dynamic> body,
  }) async {
    await instance.collection(collection).doc(doc).update(body);
  }
}
