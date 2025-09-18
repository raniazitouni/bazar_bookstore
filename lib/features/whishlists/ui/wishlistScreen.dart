import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/whishlists/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    userId = user?.id ?? "";
  }

  Future<void> _toggleWishlist(int bookId) async {
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.secondary,
          content: Text(
            "Please log in first",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    await ref
        .read(wishlistControllerProvider(userId).notifier)
        .toggleWishlist(userId, bookId);
  }

  @override
  Widget build(BuildContext context) {
    final wishlistAsync = ref.watch(wishlistControllerProvider(userId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
            height: 24,
          ),
          highlightColor: Colors.grey.withOpacity(0.2),
        ),
        title: Text(
          "Wishlist",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            child: wishlistAsync.when(
              data: (wishlist) {
                if (wishlist == null) {
                  return const Padding(
                    padding: EdgeInsets.all(50),
                    child: Text(
                      "no books in the wishlist",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                final books = wishlist.books;
                return ListView.separated(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    final isBookLiked =
                        wishlistAsync.value?.books.any(
                          (b) => b.id == book.id,
                        ) ??
                        false;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  book.coverUrl,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: AppColors.gray400,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: AppColors.gray900,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "\$${book.price.toString()}",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _toggleWishlist(book.id);
                          },
                          icon: SvgPicture.asset(
                            isBookLiked
                                ? 'assets/icons/heart_active.svg'
                                : 'assets/icons/heart_disabled.svg',
                            width: 24,
                            height: 24,
                          ),
                          highlightColor: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(height: 1, color: AppColors.gray400),
                  ),
                );
              },
              error: (err, stack) =>
                  Center(child: Text("Error: ${err.toString()}")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}
