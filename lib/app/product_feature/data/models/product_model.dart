import 'dart:convert';

import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';

class ProductModel {
  final String id;
  final String title;
  final Partner user;
  final String slug;
  final String location;
  final String description;
  final double price;
  final List<String> images;
  final Category category;
  final int visit;
  final Map<String, dynamic> details;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.user,
    required this.location,
    required this.slug,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.visit,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      user: Partner.fromJson(json['user']?? nonRegisteredUser.toJson()),
      slug: json['slug'],
      location: json['location'] ?? " location",
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images']),
      // category: Category.fromJson(json['category']),
   category: Category(
          id: "json['category']['_id']", name: "json['category']['name']"),
      visit: json['visit'],
      details: Map<String, dynamic>.from(json['details']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'user': user.toJson(),
      'slug': slug,
      'location': location,
      'description': description,
      'price': price,
      'images': images,
      'category': category.toJson(),
      'visit': visit,
      'details': details,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }


  Map<String, dynamic> createProductJson() {
    return {
      'title': title,
      'user': user.id,
      'slug': slug,
      'location': location,
      'description': description,
      'price': price,
      'images': images,
      'category': category.id,
      'visit': visit,
      'details': jsonEncode(details),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? location,
    String? description,
    double? price,
    List<String>? images,
    Category? category,
    int? visit,
    Map<String, dynamic>? details,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      user: user,
      location: location ?? this.location,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      category: category ?? this.category,
      visit: visit ?? this.visit,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Category {
  final String? id;
  final String name;

  Category({
    this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }

  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class Partner {
  final String id;
  final String name;
  final String? phone;
  final String? profileImg;
  final String? notificationToken;
  final Role role;

  Partner({
    required this.id,
    required this.name,
    this.phone,
    this.notificationToken,
    this.profileImg,
    required this.role,
  });

  // From JSON
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['_id'],
      name: json['name'],
      notificationToken: json['notificationToken'],
      phone: json['phone'],
      profileImg: json['profileImg'],
      role: _roleFromString(json['role']??"unregistered" ),
    );
  }
  static Role _roleFromString(String role) {
    switch (role) {
      case 'admin':
        return Role.admin;
      case 'user':
        return Role.user;
      case 'unregistered':
        return Role.unregistered;
      default:
        throw ArgumentError('Invalid role: $role');
    }
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'notificationToken': notificationToken,
      'phone': phone,
      'profileImg': profileImg,
      'role': role,
    };
  }
}
