import 'dart:async';
import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:bazar_bookstore/features/books/providers/book_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BookController extends AsyncNotifier<List<Book>> {
  @override
  FutureOr<List<Book>> build() async {
    return [];
  }

  Future<void> getAllBooks() async {
    final repo = ref.read(bookRepositoryProvider);
    state = await AsyncValue.guard(repo.getAllBooks);
  } 
}

final BookControllerProvider = AsyncNotifierProvider<BookController, List<Book>>(
  BookController.new,
);
