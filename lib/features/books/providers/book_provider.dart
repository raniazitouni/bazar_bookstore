import 'package:bazar_bookstore/features/books/controllers/book_controller.dart';
import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:bazar_bookstore/features/books/repository/book_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});

enum BookCategory {
  all,
  fiction,
  nonfiction,
  fantasy,
  sciFi,
  mystery,
  romance,
  horror,
  biography,
  history,
  science,
  poetry,
  drama,
  other,
}

final selectedCategoryProvider = StateProvider<BookCategory>((ref) {
  return BookCategory.all;
});

final filteredBooksProvider = Provider<AsyncValue<List<Book>>>((ref) {
  final selected = ref.watch(selectedCategoryProvider);
  final booksAsync = ref.watch(BookControllerProvider);

  return booksAsync.whenData((books) {
    if (selected == BookCategory.all) return books;
    return books.where((b) => b.category == selected).toList();
  });
});
