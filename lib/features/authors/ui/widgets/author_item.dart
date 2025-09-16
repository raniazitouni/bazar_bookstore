import 'dart:ui';

import 'package:bazar_bookstore/features/authors/models/author_model.dart';
import 'package:flutter/material.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';

class AuthorItem extends StatelessWidget {
  final Author author;

  const AuthorItem({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    final hasPicture = (author.pictureUrl?.isNotEmpty ?? false);
    return Container(
      width: 102,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 51,
            backgroundColor: AppColors.gray50,
            backgroundImage: hasPicture
                ? NetworkImage(author.pictureUrl!)
                : null,
            child: !hasPicture
                ? Icon(Icons.person, size: 51, color: AppColors.gray500)
                : null,
          ),
          const SizedBox(height: 3),
          Text(
            author.fullName,
            style: const TextStyle(
              color: AppColors.gray900,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            author.category,
            style: const TextStyle(
              color: AppColors.gray500,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
