enum Role { user, admin, unregistered }

class UserModel {
  final String id;
  final String name;
  final String? slug;
  final String email;
  final String? phone;
  final String? profileImg;
  final String? notificationToken;
  final Role role;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    this.slug,
    required this.email,
    this.phone,
    this.notificationToken,
    this.profileImg,
    required this.role,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  // Deserialize from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      email: json['email'],
      phone: json['phone'],
      profileImg: json['profileImg'],
      role: _roleFromString(json['role']),
      notificationToken: json['notificationToken'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'email': email,
      'phone': phone,
      'profileImg': profileImg,
      'notificationToken': notificationToken,
      'role': role.toString().split('.').last, // Convert enum to string
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> updateToJson() {
    if (notificationToken == null) {
      return {
        'name': name,
        'email': email,
        'phone': phone,
      };
    }
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'notificationToken': notificationToken,
    };
  }

  // Convert string to Role enum
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

  UserModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? email,
    String? phone,
    String? profileImg,
    Role? role,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notificationToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImg: profileImg ?? this.profileImg,
      notificationToken: notificationToken ?? this.notificationToken,
      role: role ?? this.role,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
