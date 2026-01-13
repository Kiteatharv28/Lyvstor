class Product {
  final String id;
  final String title;
  final String description;
  final String price;
  final String originalPrice;
  final String discount;
  final String category;
  final bool inStock;
  final DateTime createdAt;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.category,
    required this.inStock,
    required this.createdAt,
    required this.image,
  });

  int get priceInt => int.parse(price);
  int get originalPriceInt => int.parse(originalPrice);

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toString() ?? '0',
      originalPrice: data['originalPrice']?.toString() ?? '0',
      discount: data['discount'] ?? '0%',
      category: data['category'] ?? '',
      inStock: data['inStock'] ?? true,
      createdAt: data['createdAt'] is DateTime
          ? data['createdAt']
          : DateTime.parse(data['createdAt']?.toString() ?? DateTime.now().toIso8601String()),
      image: data['image'] ?? 'assets/live image.png',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'category': category,
      'inStock': inStock,
      'createdAt': createdAt.toIso8601String(),
      'image': image,
    };
  }
}
