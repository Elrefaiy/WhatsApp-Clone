import 'package:whatsapp_clone/features/home/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String name,
    required String phone,
    required String about,
    required String image,
    required String uId,
  }) : super(name: name, phone: phone, about: about, image: image, uId: uId);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      about: json['about'],
      image: json['image'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'about': about,
      'image': image,
      'uId': uId,
    };
  }
}
