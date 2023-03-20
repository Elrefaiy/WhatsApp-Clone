import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthConsumer {
  Future<dynamic> verifyPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
    required verificationCompleted,
    required verificationFailed,
    required codeSent,
    required codeAutoRetrievalTimeout,
  });
  Future<dynamic> signInWithCredential({
    required PhoneAuthCredential credential,
  });
  User get currentUser;
  Future<dynamic> signOut();
}

class FirebaseAuthConsumerImpl implements FirebaseAuthConsumer {
  final FirebaseAuth instance;

  FirebaseAuthConsumerImpl({required this.instance});

  @override
  Future verifyPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
    required verificationCompleted,
    required verificationFailed,
    required codeSent,
    required codeAutoRetrievalTimeout,
  }) async {
    await instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  User get currentUser {
    return instance.currentUser!;
  }

  @override
  Future signInWithCredential({required PhoneAuthCredential credential}) async {
    await instance.signInWithCredential(credential);
  }

  @override
  Future signOut() async {
    await instance.signOut();
  }
}
