import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/extensions/build_context_extension.dart';
import '../common/widgets/common_scaffold.dart';
import '../common/widgets/common_text_field.dart';
import '../translations/locale_keys.g.dart';
import 'model/review.dart';
import 'provider/restaurant_add_review_provider.dart';
import 'provider/restaurant_provider.dart';

class RestaurantReviewPage extends HookConsumerWidget {
  const RestaurantReviewPage({super.key, required this.restaurantId});

  final int restaurantId;

  static Route<dynamic> route({required int restaurantId}) {
    return MaterialPageRoute(
      builder: (_) => RestaurantReviewPage(restaurantId: restaurantId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(restaurantAddReviewProvider);
    _listenOnReviewAdded(ref, context);

    final userController = useTextEditingController();
    final reviewController = useTextEditingController();
    final rating = useState<int?>(null);

    final addButton = ElevatedButton(
      onPressed: rating.value != null
          ? () {
              notifier.addReview(
                restaurantId: restaurantId,
                rating: rating.value ?? 0,
                review: userController.text.isNotEmpty &&
                        reviewController.text.isNotEmpty
                    ? Review(
                        user: userController.text,
                        comment: reviewController.text,
                      )
                    : null,
              );
            }
          : null,
      child: Text(tr(LocaleKeys.add_new)),
    );

    return CommonScaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.add_review))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonTextField(
              controller: userController,
              label: tr(LocaleKeys.name),
            ),
            const SizedBox(height: 16),
            CommonTextField(
              controller: reviewController,
              maxLines: 5,
              minLines: 3,
              label: tr(LocaleKeys.review),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () => rating.value = i,
                    icon: const Icon(Icons.star),
                    color:
                        i <= (rating.value ?? 0) ? Colors.amber : Colors.grey,
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Align(child: addButton),
          ],
        ),
      ),
    );
  }

  void _listenOnReviewAdded(WidgetRef ref, BuildContext context) {
    ref.listen(restaurantAddReviewProvider, (_, next) {
      next.state.whenOrNull(
        success: (_) {
          ref.read(restaurantProvider).fetchRestaurants();
          Navigator.of(context).pop();
        },
        failure: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr(LocaleKeys.error)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: context.colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        },
      );
    });
  }
}
