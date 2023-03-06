import 'dart:io';

import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone/core/firebase/firebase_auth.dart';
import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/core/firebase/firebase_storage.dart';
import 'package:whatsapp_clone/core/network/network_info.dart';
import 'package:whatsapp_clone/features/authentication/domain/repositories/update_image_repo.dart';

class UpdateUserImageRepositoryImpl implements UpdateUserImageRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestoreConsumer storeInstance;
  final FirebaseAuthConsumer authInstance;
  final FirebaseStorageConsumer storageInstance;

  UpdateUserImageRepositoryImpl({
    required this.networkInfo,
    required this.storeInstance,
    required this.storageInstance,
    required this.authInstance,
  });
  @override
  Future<Either<Failure, dynamic>> updateUserImage({
    required File image,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await storageInstance.upload(
          path:
              'users/${authInstance.currentUser.uid}/${Uri.file(image.path).pathSegments.last}',
          file: image,
          function: (value) {
            storeInstance.update(
              collection: 'users',
              doc: authInstance.currentUser.uid,
              body: {
                'image': value,
              },
            );
          },
        );
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw const NoInternetConnectionException();
    }
  }
}

/*
pick image camera or gallery
noImagePicked ? return failure;
cropImage
notcropped ? return failure;
uploadImage
updateImage
*/

// void updateProfileImage({required String image}) {
//   FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
//     'image': image,
//   }).then((value) {
//     // emit(UpdateUserSuccessState());
//     getCurrentUser();
//   }).catchError((error) {
//     // emit(UpdateUserErrorState(error.toString()));
//   });
// }

// void uploadProfilePicture() {
//   final currentUser = FirebaseAuth.instance.currentUser!;
//   // emit(UpdateUserLoadingState());
//   firebase_storage.FirebaseStorage.instance
//       .ref()
//       .child(
//           'users/${currentUser.uid}/${Uri.file(profileImage.path).pathSegments.last}')
//       .putFile(profileImage)
//       .then((value) {
//     value.ref.getDownloadURL().then((value) {
//       updateProfileImage(image: value);
//     }).catchError((error) {
//       // emit(UploadProfileImageErrorState());
//     });
//   }).catchError((error) {
//     // emit(UpdateUserErrorState(error.toString()));
//   });
// }
