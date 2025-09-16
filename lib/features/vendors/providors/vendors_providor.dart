import 'package:bazar_bookstore/features/vendors/repository/vendors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  return VendorRepository();
});
