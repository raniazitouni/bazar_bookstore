import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/books/controllers/book_controller.dart';
import 'book_item.dart';

class BookList extends ConsumerStatefulWidget {
  const BookList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookListState();
}

class _BookListState extends ConsumerState<BookList> {
  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(BookControllerProvider);

    return SizedBox(
      height: 300,
      child: booksAsync.when(
        data: (books) {
          return (books.isEmpty)
              ? const Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "no books available",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookItem(book: book);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                );
        },
        error: (err, stack) => Center(child: Text("Error: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
