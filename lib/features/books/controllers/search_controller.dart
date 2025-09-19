import 'dart:async';
import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:bazar_bookstore/features/books/providers/book_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchController extends AsyncNotifier<List<Book>> {
  List<String> recentSearches = [];

  @override
  FutureOr<List<Book>> build() {
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final books = await ref.read(bookRepositoryProvider).searchBooks(query);
      state = AsyncValue.data(books);

      if (!recentSearches.contains(query)) {
        recentSearches.insert(0, query);
        if (recentSearches.length > 5) {
          recentSearches.removeLast();
        }
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final searchControllerProvider =
    AsyncNotifierProvider<SearchController, List<Book>>(SearchController.new);
