class ProductModel {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final String category;
  final String image;
  final RatingModel? rate;

  ProductModel(
      {required this.id,
      required this.rate,
      required this.name,
      required this.description,
      required this.price,
      required this.category,
      required this.image});
  factory ProductModel.fromJson(json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      rate: json[''] == null ? null : RatingModel.fromJson(json['rating']),
    );
  }
}

class RatingModel {
  final num rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(json) {
    return RatingModel(rate: json['rate'], count: json['count']);
  }
}
