import 'package:whatsapp_clone/core/firebase/firebase_firestore.dart';
import 'package:whatsapp_clone/features/home/data/models/status_model.dart';

abstract class GetStatusRemoteDataSource {
  Future<Map<String, List<StatusModel>>> getStatus({
    required List<String> uId,
  });
}

class GetStatusRemoteDataSourceImpl implements GetStatusRemoteDataSource {
  final FirebaseFirestoreConsumer storeInstance;
  GetStatusRemoteDataSourceImpl({
    required this.storeInstance,
  });

  @override
  Future<Map<String, List<StatusModel>>> getStatus({
    required List<String> uId,
  }) async {
    return await storeInstance.getStatus(uId: uId);
  }
}
