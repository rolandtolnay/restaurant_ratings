import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extension.dart';
import '../model/restaurant.dart';
import 'rating_widget.dart';

class RestaurantListTile extends StatelessWidget {
  const RestaurantListTile({super.key, required this.restaurant, this.onTap});

  final Restaurant restaurant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      restaurant.name,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  RatingWidget(ratingList: restaurant.ratings),
                ],
              ),
              const SizedBox(height: 8),
              Text('${restaurant.typeEmoji} ${restaurant.type}'),
              const SizedBox(height: 16),
              Text('📍 ${restaurant.location}'),
            ],
          ),
        ),
      ),
    );
  }
}
