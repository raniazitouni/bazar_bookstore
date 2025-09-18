import 'package:bazar_bookstore/features/vendors/models/vendor_model.dart';
import 'package:flutter/material.dart';

class VendorItem extends StatelessWidget {
  final Vendor vendor;

  const VendorItem({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          vendor.logoUrl,
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
