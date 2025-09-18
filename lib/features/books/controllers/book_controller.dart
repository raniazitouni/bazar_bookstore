import 'dart:async';
import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:bazar_bookstore/features/books/providers/book_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookController extends FamilyAsyncNotifier<Book?, int> {
  @override
  Future<Book?> build(int id) async {
    return getBookById(id);
  }

  Future<Book?> getBookById(int id) async {
    final repo = ref.read(bookRepositoryProvider);
    return repo.getBookById(id);
  }
}

final BookControllerProvider = FutureProvider<List<Book>>((ref) async {
  final repo = ref.read(bookRepositoryProvider);
  return repo.getAllBooks();
});

final bookByIdProvider =
    AsyncNotifierProviderFamily<BookController, Book?, int>(BookController.new);
