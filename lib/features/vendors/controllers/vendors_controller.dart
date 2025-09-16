import 'dart:async';
import 'package:bazar_bookstore/features/vendors/models/vendor_model.dart';
import 'package:bazar_bookstore/features/vendors/providors/vendors_providor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorController extends AsyncNotifier<List<Vendor>> {
  @override
  FutureOr<List<Vendor>> build() async {
    return [];
  }

  Future<void> getAllVendors() async {
    final repo = ref.read(vendorRepositoryProvider);
    state = await AsyncValue.guard(repo.getAllVendors);
  }
}

final vendorControllerProvider =
    AsyncNotifierProvider<VendorController, List<Vendor>>(VendorController.new);
