import 'package:whatsapp_clone/features/home/domain/entities/status.dart';

class StatusModel extends Status {
  const StatusModel({
    required String status,
    required String caption,
    required String dateTime,
    required bool isImage,
    required int color,
  }) : super(
          status: status,
          caption: caption,
          dateTime: dateTime,
          isImage: isImage,
          color: color,
        );

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      status: json['status'],
      caption: json['caption'],
      dateTime: json['dateTime'],
      isImage: json['isImage'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'caption': caption,
      'dateTime': dateTime,
      'isImage': isImage,
      'color': color,
    };
  }
}
