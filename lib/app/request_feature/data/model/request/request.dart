import 'course.dart';

class RequestModel {
  String? id;
  Course? course;
  String? status;
  DateTime? createdAt;

  RequestModel({this.id, this.course, this.status, this.createdAt});

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json['_id'] as String?,
        course: json['course'] == null
            ? null
            : Course.fromJson(json['course'] as Map<String, dynamic>),
        status: json['status'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'course': course?.toJson(),
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
      };
}
