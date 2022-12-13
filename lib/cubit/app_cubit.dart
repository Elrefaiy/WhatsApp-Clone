import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/cubit/app_states.dart';
import 'package:whatsapp_clone/shared/network/local/cahche_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late String verificationId;

  Future<void> submitPhoneNumber({
    required String phoneNumber,
    required String country,
  }) async {
    emit(SubmitPhoneNumberLoadingState());

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$country$phoneNumber',
      timeout: const Duration(seconds: 15),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    print('Verification Completed');
    await signIn(phoneAuthCredential);
  }

  void verificationFailed(error) {
    print('Verification Faild');
    emit(SubmitPhoneNumberErrorState(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(SubmitPhoneNumberSuccessState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('Code Auto Retrieval Timeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    emit(SignInLoadingState());
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      CacheHelper.putData(
        key: 'token',
        value: credential.token.toString(),
      );
      emit(SignInSuccessState());
    } catch (error) {
      emit(SignInErrorState(error.toString()));
    }
  }

  Future<void> logout() async {
    CacheHelper.removeData(key: 'token');
    await FirebaseAuth.instance.signOut();
  }

  int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  bool isDark = true;
  void changeMode() {
    isDark = !isDark;
    emit(ChangeThemeModeState());
  }
}
