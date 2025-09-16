import 'package:bazar_bookstore/features/books/repository/book_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});
