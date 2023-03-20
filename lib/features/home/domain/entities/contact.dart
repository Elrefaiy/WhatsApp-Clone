import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String name;
  final String image;
  final String lastMessage;
  final String uId;

  const Contact({
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.uId,
  });

  @override
  List<Object?> get props => [name, image, lastMessage, uId];
}
