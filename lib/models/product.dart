class Product {
  final String id;
  final String name;
  final String image;
  final String category;
  final double price;
  final double rating;
  final String description;
  final bool featured;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.featured,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'rating': rating,
      'description': description,
      'featured': featured,
    };
  }

  factory Product.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Product(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      description: data['description'] ?? '',
      featured: data['featured'] ?? false,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      featured: json['featured'] ?? false,
    );
  }
}
