import 'package:json_annotation/json_annotation.dart';

import '../../common/search/common_search_provider.dart';
import 'review.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant implements Searchable {
  final int id;

  final String name;
  final String type;
  final String location;
  final Iterable<int> ratings;
  final Iterable<Review> reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.ratings,
    required this.reviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  String get typeEmoji => switch (type.toLowerCase()) {
        'olasz' => '🍕',
        'vegetáriánus' => '🥗',
        'magyar' => '🍖',
        _ => '🍽️'
      };

  Restaurant addingRating({required int rating, Review? review}) {
    return Restaurant(
      id: id,
      name: name,
      type: type,
      location: location,
      ratings: [...ratings, rating],
      reviews: review != null ? [...reviews, review] : reviews,
    );
  }

  @override
  bool matchesQuery(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
        type.toLowerCase().contains(query.toLowerCase()) ||
        location.toLowerCase().contains(query.toLowerCase());
  }
}
