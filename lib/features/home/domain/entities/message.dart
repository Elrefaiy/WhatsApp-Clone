import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  final String time;
  final String date;
  final String dateTime;
  final String recieverId;

  const Message({
    required this.message,
    required this.time,
    required this.date,
    required this.dateTime,
    required this.recieverId,
  });

  @override
  List<Object?> get props => [message, time, date, dateTime, recieverId];
}
