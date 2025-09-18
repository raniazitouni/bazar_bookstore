import 'dart:ui';

import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/vendors/controllers/vendors_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'vendor_logo.dart';

class VendorList extends ConsumerStatefulWidget {
  const VendorList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VendorListState();
}

class _VendorListState extends ConsumerState<VendorList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(vendorControllerProvider.notifier).getAllVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorsAsync = ref.watch(vendorControllerProvider);

    return SizedBox(
      height: 100,
      child: vendorsAsync.when(
        data: (vendors) {
          return vendors.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "no vendors available",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final vendor = vendors[index];
                    return VendorItem(vendor: vendor);
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
