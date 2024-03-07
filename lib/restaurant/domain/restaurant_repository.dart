import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

import '../model/restaurant.dart';
import '../model/restaurant_response.dart';
import '../model/review.dart';

abstract class RestaurantRepository {
  Future<Iterable<Restaurant>> fetchRestaurants();

  Future<void> addReview({
    required int restaurantId,
    required int rating,
    Review? review,
  });
}

@LazySingleton(as: RestaurantRepository)
class FirRestaurantRepository implements RestaurantRepository {
  final File _db;

  FirRestaurantRepository(this._db);

  @override
  Future<Iterable<Restaurant>> fetchRestaurants() async {
    final response = await _db.readAsString();
    final data = json.decode(response) as Map<String, dynamic>;
    return RestaurantResponse.fromJson(data).restaurantList;
  }

  @override
  Future<void> addReview({
    required int restaurantId,
    required int rating,
    Review? review,
  }) async {
    final existing = await fetchRestaurants();

    final restaurant = existing.firstWhereOrNull((r) => r.id == restaurantId);
    if (restaurant == null) return;

    final updated = restaurant.addingRating(rating: rating, review: review);
    final newData = existing.map((r) => r.id == restaurantId ? updated : r);

    final modifiedJson = json.encode(
      RestaurantResponse(restaurantList: newData).toJson(),
    );
    await _db.writeAsString(modifiedJson);
  }
}
