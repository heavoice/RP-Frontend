import 'package:flutter_riverpod/legacy.dart';
import 'package:frontend/services/search_service.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, List<dynamic>?>(
  (ref) => SearchNotifier(),
);

class SearchNotifier extends StateNotifier<List<dynamic>?> {
  SearchNotifier() : super(null);

  Future<void> quickSearch({
    String? location,
    String? propertyType,
    int? priceMin,
    int? priceMax,
  }) async {
    try {
      final result = await SearchService.quickSearch(
        location: location,
        propertyType: propertyType,
        priceMin: priceMin,
        priceMax: priceMax,
      );

      state = result;
    } catch (e) {
      state = [];

      rethrow;
    }
  }

  void clear() {
    state = null;
  }
}
