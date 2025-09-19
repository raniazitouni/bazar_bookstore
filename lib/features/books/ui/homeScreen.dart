import 'dart:ui';

import 'package:bazar_bookstore/features/authors/ui/widgets/author_list.dart';
import 'package:bazar_bookstore/features/vendors/ui/widgets/vendor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'widgets/list_header.dart';
import 'widgets/book_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // appbar
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24,
                height: 24,
              ),
              highlightColor: Colors.grey.withOpacity(0.2),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: AppColors.gray900,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Books
                ListHeader(
                  title: "Top of Week",
                  seeAll: () {
                    Navigator.pushNamed(context, "/books");
                  },
                ),
                const BookList(),

                // Vendors
                ListHeader(
                  title: "Best Vendors",
                  seeAll: () {
                    Navigator.pushNamed(context, "/vendors");
                  },
                ),
                const VendorList(),

                // Authors
                ListHeader(
                  title: "Authors",
                  seeAll: () {
                    Navigator.pushNamed(context, "/authors");
                  },
                ),
                const AuthorList(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
