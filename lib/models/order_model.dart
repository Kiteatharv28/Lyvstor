class OrderItem {
  final String productId;
  final String title;
  final String price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] ?? '0',
      quantity: map['quantity'] ?? 1,
    );
  }
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final Map<String, dynamic> totals;
  final Map<String, dynamic> address;
  final String status; // PLACED, CANCELLED
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totals,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool canCancel() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inMinutes <= 5 && status == 'PLACED';
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totals': totals,
      'address': address,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Order.fromMap(String id, Map<String, dynamic> map) {
    return Order(
      id: id,
      userId: map['userId'] ?? '',
      items: (map['items'] as List?)
              ?.map((item) => OrderItem.fromMap(item))
              .toList() ??
          [],
      totals: map['totals'] ?? {},
      address: map['address'] ?? {},
      status: map['status'] ?? 'PLACED',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }
}
