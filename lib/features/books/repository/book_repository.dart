import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  final supabase = Supabase.instance.client;

  Future<List<Book>> getAllBooks() async {
    try {
      final response = await supabase
          .from('books')
          .select('id, title, price, cover_url');


      final books = (response as List<dynamic>).map((row) {
        return Book.fromJson(row);
      }).toList();

      return books;
      
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }
}
