import 'package:bazar_bookstore/core/shared_widgets/category_list.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/books/controllers/search_controller.dart';
import 'package:bazar_bookstore/features/books/ui/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchControllerProvider);
    final searchController = ref.read(searchControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
            height: 24,
          ),
          highlightColor: Colors.grey.withOpacity(0.2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // recherche feild
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                searchController.search(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search, color: AppColors.gray500),
                filled: true,
                fillColor: AppColors.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // historique si aucun résultat
            if (_controller.text.isEmpty) ...[
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 8),
              ...searchController.recentSearches.map(
                (s) => ListTile(
                  title: Text(
                    s,
                    style: const TextStyle(color: AppColors.gray600),
                  ),
                  onTap: () {
                    _controller.text = s;
                    searchController.search(s);
                  },
                ),
              ),
            ],

            // résultats
            if (_controller.text.isNotEmpty)
              GridList(
                items: searchState,
                widgetItem: (context, book) => BookItem(book: book),
                label: "books",
                aspectRatio: 0.6,
              ),
          ],
        ),
      ),
    );
  }
}
