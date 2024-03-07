import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../debouncer.dart';

abstract class Searchable {
  bool matchesQuery(String query);
}

final commonSearchProvider = ChangeNotifierProvider.autoDispose
    .family<CommonSearchNotifier, Iterable<Searchable>>((ref, allItems) {
  return CommonSearchNotifier(allItems);
});

class CommonSearchNotifier extends ChangeNotifier {
  final Iterable<Searchable> _allSearchables;

  CommonSearchNotifier(this._allSearchables) {
    _applyFilters();
  }

  Iterable<Searchable> _filteredSearchableList = [];
  String _searchQuery = '';

  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 300));

  bool get hasFilter => _searchQuery.isNotEmpty;

  List<Searchable> get filteredSearchableList =>
      _filteredSearchableList.toList();

  void filterInput(String value) {
    // more natural UX simulating network call
    _debouncer.run(() {
      _searchQuery = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    if (_searchQuery.isEmpty) {
      _filteredSearchableList = _allSearchables;
    } else {
      _filteredSearchableList = _allSearchables.where(
        (e) => e.matchesQuery(_searchQuery),
      );
    }
    notifyListeners();
  }
}
