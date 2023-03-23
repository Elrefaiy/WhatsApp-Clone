import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final String status;
  final String caption;
  final String dateTime;
  final bool isImage;
  final int color;

  const Status({
    required this.status,
    required this.caption,
    required this.dateTime,
    required this.isImage,
    required this.color,
  });

  @override
  List<Object?> get props => [status, caption, dateTime, isImage, color];
}
