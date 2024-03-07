import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/request_notifier.dart';
import '../../common/request_state.dart';
import '../../injectable.dart';
import '../domain/restaurant_repository.dart';
import '../model/restaurant.dart';

final restaurantProvider =
    ChangeNotifierProvider.autoDispose<RestaurantNotifier>(
  (ref) => RestaurantNotifier(getIt()),
);

final restaurantForId = Provider.autoDispose.family<Restaurant?, int>(
  (ref, id) => ref
      .watch(restaurantProvider)
      .allRestaurants
      .firstWhereOrNull((r) => r.id == id),
);

class RestaurantNotifier extends RequestNotifier<Iterable<Restaurant>> {
  final RestaurantRepository _repository;

  RestaurantNotifier(this._repository);

  Future<void> fetchRestaurants() {
    return executeRequest(() => _repository.fetchRestaurants());
  }

  Iterable<Restaurant> get allRestaurants =>
      state.hasValueOrElse(hasValue: (v, _) => v, orElse: () => []);
}
