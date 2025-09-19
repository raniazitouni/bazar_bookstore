import 'package:bazar_bookstore/features/authors/models/author_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorRepository {
  final supabase = Supabase.instance.client;

  Future<List<Author
  >> getAllAuthors() async {
    try { 
      final response = await supabase
          .from('authors')
          .select('fullname, picture_url, category');

      final authors = (response as List<dynamic>).map((row) {
        return Author.fromJson(row);
      }).toList();

      return authors;
    } catch (e) {
      throw Exception("failed to fetch authors : $e");
    }
  }
}
