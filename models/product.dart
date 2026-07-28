class Product {
  int? id;
  String name;
  String description;
  double price;
  String barcode;
  String category;
  String? image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.barcode,
    required this.category,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'barcode': barcode,
      'category': category,
      'image': image,
    };
  }
}
