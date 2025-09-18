import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';

class CategoryBar<T> extends ConsumerWidget {
  final List<T> categories;
  final T selected;
  final ValueChanged<T> onSelected;
  final String Function(T) labelBuilder;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;
          return GestureDetector(
            onTap: () => onSelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Column(
                children: [
                  Text(
                    labelBuilder(category),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: isSelected ? AppColors.gray900 : AppColors.gray500,
                    ),
                  ),
                  isSelected
                      ? Container(
                          margin: EdgeInsets.only(top: 4),
                          height: 2,
                          width: 15,
                          color: AppColors.primary,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
