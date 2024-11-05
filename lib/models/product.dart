class Product {
  num? id;
  String? title;
  String? description;
  num? price;
  List<String>? images;
  String? thumbnail;

  Product();

  Product.complete({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.thumbnail,
  });

  Product fromJson(Map<String, dynamic> json) {
    return Product.complete(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      images: json.containsKey('images') ? ((json['images'] as List).map((e) => e.toString()).toList()) : [],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}
