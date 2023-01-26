class StatusModel {
  late String status;
  late String caption;
  late String time;
  late String date;
  late String dateTime;
  late bool isImage;
  late int color;
  StatusModel({
    required this.status,
    required this.caption,
    required this.time,
    required this.date,
    required this.dateTime,
    required this.isImage,
    required this.color,
  });

  StatusModel.fromJson(json) {
    status = json['status'];
    caption = json['caption'];
    time = json['time'];
    date = json['date'];
    dateTime = json['dateTime'];
    isImage = json['isImage'];
    color = json['color'];
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'caption': caption,
      'time': time,
      'date': date,
      'dateTime': dateTime,
      'isImage': isImage,
      'color': color,
    };
  }
}
