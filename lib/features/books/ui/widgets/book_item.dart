import 'dart:ui';

import 'package:bazar_bookstore/features/books/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';


class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 127,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(book.coverUrl, fit: BoxFit.cover, width: 127 ,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 50, color: AppColors.gray400),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            book.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.gray900,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "\$${book.price.toString()}",
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
