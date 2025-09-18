import 'package:bazar_bookstore/features/whishlists/models/wishlist_model.dart';
import 'package:bazar_bookstore/features/whishlists/providers/wishlist_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistController extends FamilyAsyncNotifier<WishList?, String > {
  @override
  Future<WishList?> build(String userId) async {
    return await fetchWishlist(userId);
  }

    
  Future<void> toggleWishlist(String userId, int bookId) async {
    final repo = ref.read(wishlistRepositoryProvider);
    await repo.toggleWishlist(userId, bookId);

    // refresh state after toggle
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fetchWishlist(userId));
  }

  Future<WishList?> fetchWishlist(String userId) async {
    final repo = ref.read(wishlistRepositoryProvider);
    return repo.fetchWishlist(userId);
  }

  Future<bool> isBookInWishlist(String userId , int bookId) async {
    final repo = ref.read(wishlistRepositoryProvider);
    return repo.isBookInWishlist(userId, bookId);
  }

}

final wishlistControllerProvider =
    AsyncNotifierProviderFamily<WishlistController, WishList?, String>(
      WishlistController.new);
