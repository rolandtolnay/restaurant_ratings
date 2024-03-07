import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/request_notifier.dart';
import '../../injectable.dart';
import '../domain/restaurant_repository.dart';
import '../model/review.dart';

final restaurantAddReviewProvider =
    ChangeNotifierProvider.autoDispose<RestaurantAddReviewNotifier>(
  (ref) => RestaurantAddReviewNotifier(getIt()),
);

class RestaurantAddReviewNotifier extends RequestNotifier<void> {
  final RestaurantRepository _repository;

  RestaurantAddReviewNotifier(this._repository);

  Future<void> addReview({
    required int restaurantId,
    required int rating,
    Review? review,
  }) {
    return executeRequest(
      () => _repository.addReview(
        restaurantId: restaurantId,
        rating: rating,
        review: review,
      ),
    );
  }
}
