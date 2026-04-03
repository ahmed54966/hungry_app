class ProductModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? rating;
  String? price;

  ProductModel({this.id, this.name, this.description, this.image, this.rating, this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      rating: json["rating"]?.toString(), 
      price: json["price"]?.toString(),
    );
  }
}
