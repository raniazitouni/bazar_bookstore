import 'package:bazar_bookstore/features/books/models/book_model.dart';

class WishList {
  final List<Book> books;
  final String userId;

  const WishList({ required this.books, required this.userId});

  factory WishList.fromJson(List<dynamic> rows) {
    if (rows.isEmpty) {
      return const WishList(userId: "", books: []);
    }

    final userId = rows.first['user_id'] ?? "";

    final books = rows.map((row) {
      return Book.fromJson(row['books']);
    }).toList();

    return WishList(userId: userId, books: books);
  }
}
