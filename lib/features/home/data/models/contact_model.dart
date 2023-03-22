import '../../domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    required String name,
    required String image,
    required String lastMessage,
    required String dateTime,
    required String uId,
  }) : super(
          name: name,
          image: image,
          lastMessage: lastMessage,
          dateTime: dateTime,
          uId: uId,
        );

  factory ContactModel.fromJson(json) {
    return ContactModel(
      name: json['name'],
      image: json['image'],
      lastMessage: json['lastMessage'],
      dateTime: json['dateTime'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'lastMessage': lastMessage,
      'dateTime': dateTime,
      'uId': uId,
    };
  }
}
