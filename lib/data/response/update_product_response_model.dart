import 'dart:convert';

class UpdateProductResponseModel {
  int? id;
  String? title;
  int? price;
  String? description;

  UpdateProductResponseModel({
    this.id,
    this.title,
    this.price,
    this.description,
  });

  factory UpdateProductResponseModel.fromJson(String str) =>
      UpdateProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProductResponseModel.fromMap(Map<String, dynamic> json) =>
      UpdateProductResponseModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
      };
}
