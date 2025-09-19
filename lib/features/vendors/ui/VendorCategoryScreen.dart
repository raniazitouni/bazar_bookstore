import 'dart:ui';

import 'package:bazar_bookstore/core/shared_widgets/category_bar.dart';
import 'package:bazar_bookstore/core/shared_widgets/category_list.dart';
import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/vendors/providors/vendors_providor.dart';
import 'package:bazar_bookstore/features/vendors/ui/widgets/vendor_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorCategoryScreen extends ConsumerStatefulWidget {
  const VendorCategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VendorCategoryScreenState();
}

class _VendorCategoryScreenState extends ConsumerState<VendorCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(selectedCategoryProvider);
    final vendors = ref.watch(filteredVendorsProvider);

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
          "Vendors",
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
                categories: VendorCategory.values,
                onSelected: (c) =>
                    ref.read(selectedCategoryProvider.notifier).state = c,
                labelBuilder: vendorCategoryLabel,
              ),
              GridList(
                items: vendors,
                widgetItem: (context, vendor) => Column(
                  children: [
                    VendorItem(vendor: vendor),
                    Expanded(
                      child: Text(
                        vendor.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.gray900,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    RatingBarIndicator(
                      rating: vendor.review?.rating.toDouble() ?? 0,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: AppColors.yellow),
                      itemCount: 5,
                      itemSize: 18,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                label: "vendors",
                aspectRatio: 0.7,
                crossAxisCount: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String vendorCategoryLabel(VendorCategory category) {
  switch (category) {
    case VendorCategory.all:
      return "All";
    case VendorCategory.bookstore:
      return "Bookstore";
    case VendorCategory.distributor:
      return "Distributor";
    case VendorCategory.publisher:
      return "Publisher";
    case VendorCategory.other:
      return "Other";
  }
}
