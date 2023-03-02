import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String phone;
  final String image;
  final String about;
  final String uId;

  const User({
    required this.name,
    required this.phone,
    required this.image,
    required this.about,
    required this.uId,
  });

  @override
  List<Object?> get props => [name, phone, image, about, uId];
}
