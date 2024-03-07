import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/extensions/build_context_extension.dart';
import '../common/search/common_search_input.dart';
import '../common/search/common_search_provider.dart';
import '../common/use_init_hook.dart';
import '../common/widgets/common_list_view.dart';
import '../common/widgets/common_scaffold.dart';
import '../translations/locale_keys.g.dart';
import 'model/restaurant.dart';
import 'provider/restaurant_provider.dart';
import 'restaurant_detail_page.dart';
import 'widgets/restaurant_list_tile.dart';

class RestaurantListPage extends HookConsumerWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(restaurantProvider);

    useInitAsync(() => notifier.fetchRestaurants());

    final searchController = useTextEditingController();
    final searchNotifier =
        ref.watch(commonSearchProvider(notifier.allRestaurants));
    final filteredRestaurants =
        searchNotifier.filteredSearchableList.cast<Restaurant>();

    return CommonScaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.app_name)),
        actions: [
          TextButton(
            onPressed: () {
              context.setLocale(
                context.locale == const Locale('en') ? const Locale('hu') : const Locale('en'),
              );
            },
            child: Text(
              context.locale == const Locale('en') ? '🇬🇧' : '🇭🇺',
              style: context.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
      body: notifier.state.maybeWhen(
        success: (_) => Column(
          children: [
            CommonSearchInput(
              controller: searchController,
              autofocus: false,
              onChanged: searchNotifier.filterInput,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CommonListView(
                items: filteredRestaurants,
                itemBuilder: (_, r, __) => RestaurantListTile(
                  restaurant: r,
                  onTap: () => Navigator.of(context)
                      .push(RestaurantDetailPage.route(restaurantId: r.id)),
                ),
              ),
            ),
          ],
        ),
        failure: (error) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(tr(LocaleKeys.error), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Align(
              child: ElevatedButton(
                onPressed: () => notifier.fetchRestaurants(),
                child: Text(tr(LocaleKeys.retry)),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
