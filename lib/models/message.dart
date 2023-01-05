class MessageModel {
  late String message;
  late String time;
  late String date;
  late String dateTime;
  late String recieverId;

  MessageModel({
    required this.message,
    required this.time,
    required this.date,
    required this.dateTime,
    required this.recieverId,
  });

  MessageModel.fromJson(json) {
    message = json['message'];
    time = json['time'];
    date = json['date'];
    dateTime = json['dateTime'];
    recieverId = json['recieverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'time': time,
      'date': date,
      'dateTime': dateTime,
      'recieverId': recieverId,
    };
  }
}
