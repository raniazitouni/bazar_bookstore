import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  final supabase = Supabase.instance.client;

  Future<List<Book>> getAllBooks() async {
    try {
      final response = await supabase
          .from('books')
          .select('id, title, price, cover_url,category');

      final books = (response as List<dynamic>).map((row) {
        return Book.fromJson(row);
      }).toList();

      return books;
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }

  Future<Book?> getBookById(int id) async {
    try {
      final bookResponse = await supabase
          .from('books')
          .select('''
            id,
            title,
            price,
            cover_url,
            category,
            description,
            vendors (
              id,
              logo_url,
              category
            )
          ''')
          .eq('id', id)
          .maybeSingle();

      final reviewsResponse = await supabase
          .from('reviews')
          .select('id, rating, target_type, target_id')
          .eq('target_id', id)
          .eq('target_type', 'book')
          .maybeSingle();

      if (bookResponse == null) return null;

      final book = Book.fromJson({...bookResponse, 'reviews': reviewsResponse});

      return book;
    } catch (e) {
      throw Exception('Failed to fetch book with id $id: $e');
    }
  }
}
