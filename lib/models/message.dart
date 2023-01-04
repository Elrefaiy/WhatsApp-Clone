class MessageModel {
  late String message;
  late String time;
  late String date;
  late String recieverId;

  MessageModel({
    required this.message,
    required this.time,
    required this.date,
    required this.recieverId,
  });

  MessageModel.fromJson(json) {
    message = json['message'];
    time = json['time'];
    date = json['date'];
    recieverId = json['recieverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'time': time,
      'date': date,
      'recieverId': recieverId,
    };
  }
}
