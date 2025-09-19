import 'package:bazar_bookstore/features/reviews/models/review_model.dart';
import 'package:bazar_bookstore/features/vendors/providors/vendors_providor.dart';

class Vendor {
  final int id;
  final String title;
  final String logoUrl;
  final VendorCategory category;
  final Review? review;


  const Vendor({
    required this.id,
    required this.title,
    required this.logoUrl,
    required this.category,
    this.review
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      logoUrl: json["logo_url"] ?? "",
      category: vendorCategoryFromString(json["category"]),
      review: json['reviews'] != null ? Review.fromJson(json['reviews']) : null,
    );
  }
}


VendorCategory vendorCategoryFromString(String category) {
  switch (category.toLowerCase()) {
    case 'bookstore':
      return VendorCategory.bookstore;
    case 'distributor':
      return VendorCategory.distributor;
    case 'publisher':
      return VendorCategory.publisher;
    case 'other':
      return VendorCategory.other;
    default:
      return VendorCategory.other;
  }
}
