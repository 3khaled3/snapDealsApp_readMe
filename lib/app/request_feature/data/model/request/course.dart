class Course {
  String? id;
  String? title;
  String? description;

  Course({this.id, this.title, this.description});

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
      };
}
