class ProductModel {
  String id;
  String name;
  String description;
  String categoryId;
  double price;
  List<String> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      price: json['price'].toDouble(),
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'price': price,
      'images': images,
    };
  }
}
