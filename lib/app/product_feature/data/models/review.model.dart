

class ReviewModel {
  String? id;
  User? user;
  String? course;
  int? rating;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReviewModel({
    this.id,
    this.user,
    this.course,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['_id'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        course: json['course'] as String?,
        rating: json['rating'] as int?,
        comment: json['comment'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user?.toJson(),
        'course': course,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

   Map<String, dynamic> createToJson() => {
      
        
        'rating': rating,
        'comment': comment,
      
      };   
}

class User {
  String? id;
  String? name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
