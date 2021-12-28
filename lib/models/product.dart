import 'package:json_annotation/json_annotation.dart';

import 'rating.dart';

part 'product.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  Product(this.id, this.title, this.price, this.description, this.category,
      this.image, this.rating);
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<dynamic, dynamic> toJson() => _$ProductToJson(this);
}
