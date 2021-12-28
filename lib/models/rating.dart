import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Rating {
  double rate;
  int count;

  Rating(this.rate, this.count);
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<dynamic, dynamic> toJson() => _$RatingToJson(this);
}
