import 'dart:ui';

import 'package:bazar_bookstore/core/shared_widgets/category_bar.dart';
import 'package:bazar_bookstore/core/shared_widgets/category_list.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/authors/providers/author_providor.dart';
import 'package:bazar_bookstore/features/authors/ui/widgets/author_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthorCategoryScreen extends ConsumerStatefulWidget {
  const AuthorCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthorCategoryScreenState();
}

class _AuthorCategoryScreenState extends ConsumerState<AuthorCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedCategoryProvider);
    final authors = ref.watch(filteredAuthorsProvider);

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
          "Authors",
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
                categories: AuthorCategory.values,
                onSelected: (c) =>
                    ref.read(selectedCategoryProvider.notifier).state = c,
                labelBuilder: authorCategoryLabel,
              ),
              GridList(
                items: authors,
                widgetItem: (context, author) => AuthorItem(author: author),
                label: "authors",
                aspectRatio: 0.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String authorCategoryLabel(AuthorCategory category) {
  switch (category) {
    case AuthorCategory.all:
      return "All";
    case AuthorCategory.novelist:
      return "Novelist";
    case AuthorCategory.poet:
      return "Poet";
    case AuthorCategory.playwright:
      return "Play Wright";
    case AuthorCategory.journalist:
      return "Journalist";
    case AuthorCategory.essayist:
      return "Essayist";
    case AuthorCategory.children:
      return "Children";
    case AuthorCategory.biographer:
      return "Biographer";
    case AuthorCategory.technical:
      return "Technical";
    case AuthorCategory.screenwriter:
      return "Screen Writer";
    case AuthorCategory.academic:
      return "Academic";
    case AuthorCategory.other:
      return "Other";
  }
}
