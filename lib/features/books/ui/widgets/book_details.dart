import 'dart:ui';

import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/books/controllers/book_controller.dart';
import 'package:bazar_bookstore/features/vendors/ui/widgets/vendor_logo.dart';
import 'package:bazar_bookstore/features/whishlists/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookDetails extends ConsumerStatefulWidget {
  final int bookId;
  const BookDetails({super.key, required this.bookId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailsState();
}

class _BookDetailsState extends ConsumerState<BookDetails> {
  bool isLiked = false;
  String userId = "";

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    userId = user?.id ?? "";
    if (userId.isNotEmpty) _isBookInWishlist();
  }

  Future<void> _isBookInWishlist() async {
    final exists = await ref
        .read(wishlistControllerProvider(userId).notifier)
        .isBookInWishlist(userId, widget.bookId);

    if (mounted) {
      setState(() {
        isLiked = exists;
      });
    }
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

    if (mounted) {
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookAsync = ref.watch(bookByIdProvider(widget.bookId));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.6,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              children: [
                // drag handle
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.gray400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
                bookAsync.when(
                  data: (book) {
                    if (book == null) {
                      return const Padding(
                        padding: EdgeInsets.all(50),
                        child: Text(
                          "no books available with this id ",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    final isVendor = book.vendor != null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // the book cover
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              book.coverUrl,
                              fit: BoxFit.cover,
                              width: 240,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: AppColors.gray400,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // the book title + like button 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                book.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: AppColors.gray900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _toggleWishlist(book.id);
                              },
                              icon: SvgPicture.asset(
                                isLiked
                                    ? 'assets/icons/heart_active.svg'
                                    : 'assets/icons/heart_disabled.svg',
                                width: 24,
                                height: 24,
                              ),
                              highlightColor: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        //the vendor logo 
                        isVendor
                            ? VendorItem(vendor: book.vendor!)
                            : SizedBox.shrink(),
                        const SizedBox(height: 10),
                        // the book description 
                        Text(
                          book.description,
                          style: const TextStyle(
                            color: AppColors.gray500,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // the book review 
                        Text(
                          "Review",
                          style: const TextStyle(
                            color: AppColors.gray900,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        RatingBarIndicator(
                          rating: 4 /*book.review?.rating.toDouble() ?? 0*/,
                          itemBuilder: (context, index) =>
                              const Icon(Icons.star, color: AppColors.yellow),
                          itemCount: 5,
                          itemSize: 30,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(height: 10),
                        // the book price 
                        Text(
                          "\$${book.price.toString()}",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // continue + view wishlist buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 50,
                                ),
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/wishlist");
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 40,
                                ),
                                backgroundColor: AppColors.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Text(
                                "View whishlist",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  error: (err, stack) =>
                      Center(child: Text("Error: ${err.toString()}")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
