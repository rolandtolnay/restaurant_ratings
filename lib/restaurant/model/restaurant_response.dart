import 'package:json_annotation/json_annotation.dart';

import 'restaurant.dart';

part 'restaurant_response.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantResponse {
  @JsonKey(name: 'restaurants')
  final Iterable<Restaurant> restaurantList;

  RestaurantResponse({required this.restaurantList});

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);
}
