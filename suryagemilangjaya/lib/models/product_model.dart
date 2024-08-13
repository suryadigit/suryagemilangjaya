class ProductModel {
  final String image;
  final String title;
  final String price;
  final String category;
  final String barcode;
  final String stock;

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
    required this.category,
    required this.barcode,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json['image'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      barcode: json['barcode'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'category': category,
      'barcode': barcode,
      'stock': stock,
    };
  }
}
