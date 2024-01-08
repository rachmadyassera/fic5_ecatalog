import 'dart:convert';

class UpdateProductRequestModel {
  String? title;
  int? price;
  String? description;

  UpdateProductRequestModel({
    this.title,
    this.price,
    this.description,
  });

  factory UpdateProductRequestModel.fromJson(String str) =>
      UpdateProductRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProductRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateProductRequestModel(
        title: json["title"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "description": description,
      };
}
