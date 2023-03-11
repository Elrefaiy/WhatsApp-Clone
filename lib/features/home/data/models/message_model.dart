import 'package:whatsapp_clone/features/home/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required String message,
    required String time,
    required String date,
    required String dateTime,
    required String recieverId,
  }) : super(
          message: message,
          time: time,
          date: date,
          dateTime: dateTime,
          recieverId: recieverId,
        );

  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json['message'],
      time: json['time'],
      date: json['date'],
      dateTime: json['dateTime'],
      recieverId: json['recieverId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time,
      'date': date,
      'dateTime': dateTime,
      'recieverId': recieverId,
    };
  }
}
