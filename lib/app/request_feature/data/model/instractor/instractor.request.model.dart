import 'sender.request.model.dart';

class InstractorRequestModel {
  String? id;
  Sender? sender;
  String? receiver;
  String? course;
  String? status;
  DateTime? createdAt;
  int? v;

  InstractorRequestModel({
    this.id,
    this.sender,
    this.receiver,
    this.course,
    this.status,
    this.createdAt,
    this.v,
  });

  factory InstractorRequestModel.fromJson(Map<String, dynamic> json) =>
      InstractorRequestModel(
        id: json['_id'] as String?,
        sender: json['sender'] == null
            ? null
            : Sender.fromJson(json['sender'] as Map<String, dynamic>),
        receiver: json['receiver'] as String?,
        course: json['course'] as String?,
        status: json['status'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sender': sender?.toJson(),
        'receiver': receiver,
        'course': course,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        '__v': v,
      };
}
