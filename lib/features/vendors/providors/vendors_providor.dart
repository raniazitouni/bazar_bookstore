import 'package:bazar_bookstore/features/vendors/controllers/vendors_controller.dart';
import 'package:bazar_bookstore/features/vendors/models/vendor_model.dart';
import 'package:bazar_bookstore/features/vendors/repository/vendors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  return VendorRepository();
});

enum VendorCategory { all, bookstore, publisher, distributor, other }

final selectedCategoryProvider = StateProvider<VendorCategory>((ref) {
  return VendorCategory.all;
});

final filteredVendorsProvider = Provider<AsyncValue<List<Vendor>>>((ref) {
  final selected = ref.watch(selectedCategoryProvider);
  final vendorsAsync = ref.watch(vendorControllerProvider);

  return vendorsAsync.whenData((vendors) {
    if (selected == VendorCategory.all) return vendors;
    return vendors.where((b) => b.category == selected).toList();
  });
});
