import 'package:bazar_bookstore/features/whishlists/repository/wishlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepository();
});
