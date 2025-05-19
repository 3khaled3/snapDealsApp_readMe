class Sender {
  String? id;
  String? name;

  Sender({this.id, this.name});

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json['_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
