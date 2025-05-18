class NotificationModel {
  final String id;
  final String title;
  final String receiverId;
  final String senderId;
  final String body;
  final String date;
  final bool isSeen;

  NotificationModel({
    required this.id,
    required this.receiverId,
    required this.senderId,
    required this.title,
    required this.body,
    required this.date,
    this.isSeen = false,
  });

  // Convert JSON to NotificationModel
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print("json['isSeen'] ${json['body']}:  ${json['isSeen']}");
    return NotificationModel(
      id: json['id'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
      isSeen: json['isSeen'],
    );
  }

  // Convert NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'receiverId': receiverId,
      'senderId': senderId,
      'date': date,
      'isSeen': isSeen,
    };
  }

  // CopyWith method for modifying properties
  NotificationModel copyWith({
    String? title,
    String? body,
    String? date,
    bool? isSeen,
  }) {
    return NotificationModel(
      id: id,
      receiverId: receiverId,
      senderId: senderId,
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      isSeen: isSeen ?? this.isSeen,
    );
  }
}
