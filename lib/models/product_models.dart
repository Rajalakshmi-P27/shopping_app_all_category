class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double discountPercentage;
  final String category;
  final double? rating;
  final int? stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.category,
    required this.image,
    this.rating,
    this.stock,
  });

  double get discountedPrice => price - (price * discountPercentage / 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    print("Product JSON: $json");

    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? "No title",
      description: json['description'] ?? "No description",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] ?? "Unknown",
      image: json['thumbnail'] ?? "",
      rating:
          json['rating'] is Map
              ? (json['rating']['rate'] as num?)?.toDouble()
              : (json['rating'] as num?)?.toDouble(),

      stock:
          json['stock'] is String
              ? int.tryParse(json['stock'])
              : json['stock'] as int?,
    );
  }
}
