class CartItem {
  final String productId;
  final String title;
  final String price;
  final int quantity;
  final int maxStock;
  final String image;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.maxStock,
    this.image = 'assets/live image.png',
  });

  int get totalPrice => int.parse(price) * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'maxStock': maxStock,
      'image': image,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] ?? '0',
      quantity: map['quantity'] ?? 1,
      maxStock: map['maxStock'] ?? 0,
      image: map['image'] ?? 'assets/live image.png',
    );
  }
}
