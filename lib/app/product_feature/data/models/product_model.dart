class ProductModel {
  final String id;
  final String userId;
  final String categoryId;
  final String brand;
  final String title;
  final String description;
  final double price;
  final List<String> imageUrl;
  // final int quantity;
  final double? rate;
  final double? discount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.brand,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    // required this.quantity,
    this.rate,
    this.discount,
    required this.createdAt,
    this.updatedAt,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'brand': brand,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      // // 'quantity': quantity,
      'rate': rate,
      'discount': discount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      categoryId: json['categoryId'] as String,
      brand: json['brand'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: List<String>.from(json['imageUrl'] as List),
      // // quantity: json['quantity'] as int,
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // Copy with
  ProductModel copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? brand,
    String? title,
    String? description,
    double? price,
    List<String>? imageUrl,
    // int? quantity,
    double? rate,
    double? discount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      // // // quantity: quantity ?? this.quantity,
      rate: rate ?? this.rate,
      discount: discount ?? this.discount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
