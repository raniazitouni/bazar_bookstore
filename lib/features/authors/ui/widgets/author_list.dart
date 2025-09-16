import 'dart:ui';

import 'package:bazar_bookstore/features/authors/controllers/author_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'Author_item.dart';

class AuthorList extends ConsumerStatefulWidget {
  const AuthorList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthorListState();
}

class _AuthorListState extends ConsumerState<AuthorList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authorControllerProvidor.notifier).getAllAuthors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authorsAsync = ref.watch(authorControllerProvidor);

    return SizedBox(
      height: 200,
      child: authorsAsync.when(
        data: (authors) {
          return authors.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "no Authors available",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: authors.length,
                  itemBuilder: (context, index) {
                    final author = authors[index];
                    return AuthorItem(author: author);
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 20),
                );
        },
        error: (err, stack) => Center(child: Text("Error: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
