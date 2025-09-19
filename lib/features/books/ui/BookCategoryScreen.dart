import 'dart:ui';

import 'package:bazar_bookstore/core/shared_widgets/category_bar.dart';
import 'package:bazar_bookstore/core/shared_widgets/category_list.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/books/providers/book_provider.dart';
import 'package:bazar_bookstore/features/books/ui/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookCategoryScreen extends ConsumerStatefulWidget {
  const BookCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookCategoryScreenState();
}

class _BookCategoryScreenState extends ConsumerState<BookCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedCategoryProvider);
    final books = ref.watch(filteredBooksProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
            height: 24,
          ),
          highlightColor: Colors.grey.withOpacity(0.2),
        ),
        title: Text(
          "Books",
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
          child: Column(
            children: [
              CategoryBar(
                selected: selected,
                categories: BookCategory.values,
                onSelected: (c) =>
                    ref.read(selectedCategoryProvider.notifier).state = c,
                labelBuilder: bookCategoryLabel,
              ),
              GridList(
                items: books,
                widgetItem: (context, book) => BookItem(book: book),
                label: "books",
                aspectRatio: 0.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String bookCategoryLabel(BookCategory category) {
  switch (category) {
    case BookCategory.all:
      return "All";
    case BookCategory.fiction:
      return "Fiction";
    case BookCategory.nonfiction:
      return "Non-Fiction";
    case BookCategory.fantasy:
      return "Fantasy";
    case BookCategory.sciFi:
      return "Sci-Fi";
    case BookCategory.mystery:
      return "Mystery";
    case BookCategory.romance:
      return "Romance";
    case BookCategory.horror:
      return "Horror";
    case BookCategory.biography:
      return "Biography";
    case BookCategory.history:
      return "History";
    case BookCategory.science:
      return "Science";
    case BookCategory.poetry:
      return "Poetry";
    case BookCategory.drama:
      return "Drama";
    case BookCategory.other:
      return "Other";
  }
}
