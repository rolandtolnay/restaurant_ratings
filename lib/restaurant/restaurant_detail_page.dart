import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/extensions/build_context_extension.dart';
import '../common/widgets/common_list_view.dart';
import '../common/widgets/common_scaffold.dart';
import '../translations/locale_keys.g.dart';
import 'provider/restaurant_provider.dart';
import 'restaurant_review_page.dart';
import 'widgets/rating_widget.dart';

class RestaurantDetailPage extends ConsumerWidget {
  const RestaurantDetailPage({super.key, required this.restaurantId});

  final int restaurantId;

  static Route<dynamic> route({required int restaurantId}) {
    return MaterialPageRoute(
      builder: (_) => RestaurantDetailPage(restaurantId: restaurantId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(restaurantForId(restaurantId));
    if (restaurant == null) return const LoadingScaffold();

    final imageIndex = Random().nextInt(8) + 1;
    return CommonScaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://generatorfun.com/code/uploads/Random-Restaurant-image-$imageIndex.jpg',
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text('🍕 ${restaurant.type}')),
              RatingWidget(ratingList: restaurant.ratings),
            ],
          ),
          const SizedBox(height: 16),
          Text('📍 ${restaurant.location}'),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  tr(LocaleKeys.reviews),
                  style: context.textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  RestaurantReviewPage.route(restaurantId: restaurant.id),
                ),
                child: Text(tr(LocaleKeys.add_new)),
              ),
            ],
          ),
          Expanded(
            child: CommonListView(
              items: restaurant.reviews.toList(),
              itemBuilder: (_, review, __) => Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        review.user,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(review.comment),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
