class Address {
  final String id;
  final String name;
  final String phone;
  final String line1;
  final String city;
  final String pincode;
  final bool isDefault;
  final DateTime updatedAt;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.line1,
    required this.city,
    required this.pincode,
    this.isDefault = false,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  bool isValid() {
    return name.isNotEmpty &&
        phone.isNotEmpty &&
        phone.length == 10 &&
        line1.isNotEmpty &&
        city.isNotEmpty &&
        pincode.isNotEmpty &&
        pincode.length == 6;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'line1': line1,
      'city': city,
      'pincode': pincode,
      'isDefault': isDefault,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Address.fromMap(String id, Map<String, dynamic> map) {
    return Address(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      line1: map['line1'] ?? '',
      city: map['city'] ?? '',
      pincode: map['pincode'] ?? '',
      isDefault: map['isDefault'] ?? false,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }
}
