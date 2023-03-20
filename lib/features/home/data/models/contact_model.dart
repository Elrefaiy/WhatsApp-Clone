import 'package:whatsapp_clone/features/home/domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    required String name,
    required String image,
    required String lastMessage,
    required String uId,
  }) : super(name: name, image: image, lastMessage: lastMessage, uId: uId);

  factory ContactModel.fromJson(json) {
    return ContactModel(
      name: json['name'],
      image: json['image'],
      lastMessage: json['lastMessage'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'uId': uId,
    };
  }
}
