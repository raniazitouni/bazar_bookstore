import 'package:bazar_bookstore/features/whishlists/models/wishlist_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistRepository {
  final supabase = Supabase.instance.client;

  Future<void> toggleWishlist(String userId, int bookId) async {
    try {
      final exist = await supabase
          .from("wishlists")
          .select()
          .eq('user_id', userId)
          .eq('book_id', bookId);

      if (exist.isNotEmpty) {
        await supabase
            .from("wishlists")
            .delete()
            .eq('user_id', userId)
            .eq('book_id', bookId);
      } else {
        await supabase.from("wishlists").insert({
          'user_id': userId,
          'book_id': bookId,
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle wishlists: $e');
    }
  }

  Future<WishList?> fetchWishlist(String userId) async {
    try {
      final response = await supabase
          .from('wishlists')
          .select('user_id , books(id, title, cover_url, price,category)')
          .eq('user_id', userId);

      final data = response as List<dynamic>;

      return WishList.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch wishlists: $e');
    }
  }

  Future<bool> isBookInWishlist(String userId, int bookId) async {
    try {
      final exist = await supabase
          .from("wishlists")
          .select()
          .eq('user_id', userId)
          .eq('book_id', bookId);

      return exist.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to toggle wishlists: $e');
    }
  }
}
