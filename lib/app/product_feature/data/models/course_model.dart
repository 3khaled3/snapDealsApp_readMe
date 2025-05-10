import 'dart:convert';

import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final int price;
  final Category category;
  final List<LessonModel> lessonModels;
  final Instructor instructor;
  final String location;
  final double ratingsAverage;
  final int ratingsQuantity;
  final String language;
  final String access;
  final bool certificate;
  final List<dynamic> pendingRequests;
  final List<dynamic> students;
  final List<dynamic> reviews;
  final int views;
  final Map<String, dynamic> details;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.category,
    required this.lessonModels,
    required this.instructor,
    required this.location,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.language,
    required this.access,
    required this.certificate,
    required this.pendingRequests,
    required this.students,
    required this.reviews,
    required this.views,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        images: List<String>.from(json['images']),
        price: json['price'],
        category: Category.fromJson(json['category']),
        lessonModels: [],
        //  List<LessonModel>.from(
        //     json['lessonModels'].map((x) => LessonModel.fromJson(x))),
        instructor: Instructor.fromJson(json['instructor']),
        location: json['location'],
        ratingsAverage: (json['ratingsAverage'] ?? 0).toDouble(),
        ratingsQuantity: json['ratingsQuantity'],
        language: json['language'],
        access: json['access'],
        certificate: json['certificate'],
        pendingRequests: json['pendingRequests'] ?? [],
        students: json['students'] ?? [],
        reviews: json['reviews'] ?? [],
        views: json['views'],
        details: Map<String, dynamic>.from(json['details']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'images': images,
        'price': price,
        'category': category.toJson(),
        'lessonModels': lessonModels.map((x) => x.toJson()).toList(),
        'instructor': instructor.toJson(),
        'location': location,
        'ratingsAverage': ratingsAverage,
        'ratingsQuantity': ratingsQuantity,
        'language': language,
        'access': access,
        'certificate': certificate,
        'pendingRequests': pendingRequests,
        'students': students,
        'reviews': reviews,
        'views': views,
        'details': details,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

       Map<String, dynamic> createCourseJson() => {
        'title': title,
        'description': description,
        'images': images,
        'price': price,
        'category': category.id,
        'lessonModels': lessonModels.map((x) => x.toJson()).toList(),
        'instructor': instructor.id,
        'location': location,
        'ratingsAverage': ratingsAverage,
        'ratingsQuantity': ratingsQuantity,
        'language': language,
        'access': access,
        'certificate': certificate,
        'pendingRequests': pendingRequests,
        'students': students,
        'reviews': reviews,
        'views': views,
        'details': jsonEncode(details),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? images,
    int? price,
    Category? category,
    List<LessonModel>? lessonModels,
    Instructor? instructor,
    String? location,
    double? ratingsAverage,
    int? ratingsQuantity,
    String? language,
    String? access,
    bool? certificate,
    List<dynamic>? pendingRequests,
    List<dynamic>? students,
    List<dynamic>? reviews,
    int? views,
    Map<String, dynamic>? details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      category: category ?? this.category,
      lessonModels: lessonModels ?? this.lessonModels,
      instructor: instructor ?? this.instructor,
      location: location ?? this.location,
      ratingsAverage: ratingsAverage ?? this.ratingsAverage,
      ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
      language: language ?? this.language,
      access: access ?? this.access,
      certificate: certificate ?? this.certificate,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      students: students ?? this.students,
      reviews: reviews ?? this.reviews,
      views: views ?? this.views,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LessonModel {
  final String id;
  final String title;

  LessonModel({required this.id, required this.title});

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      LessonModel(id: json['_id'], title: json['title']);

  Map<String, dynamic> toJson() => {'_id': id, 'title': title};
}

class Instructor {
  final String id;
  final String name;
  final String? phone;
  final String? profileImg;

  Instructor({
    required this.id,
    required this.name,
     this.phone,
     this.profileImg,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json['_id'],
        name: json['name'],
        phone: json['phone'],
        profileImg: json['profileImg'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'profileImg': profileImg,
      };
}
