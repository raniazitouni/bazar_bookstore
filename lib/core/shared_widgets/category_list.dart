import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';

class GridList<T> extends ConsumerWidget {
  final AsyncValue<List<T>> items;
  final Widget Function(BuildContext, T) widgetItem;
  final String label;
  final double aspectRatio;
  final int crossAxisCount;

  const GridList({
    super.key,
    required this.items,
    required this.widgetItem,
    required this.label,
    this.aspectRatio = 0.6,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: items.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  "no $label available in this category",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 35,
              mainAxisSpacing: 5,
              childAspectRatio: aspectRatio,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return widgetItem(context, item);
            },
          );
        },
        error: (err, stack) => Center(child: Text("Error: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
