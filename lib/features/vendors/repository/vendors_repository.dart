import 'package:bazar_bookstore/features/vendors/models/vendor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VendorRepository {
  final supabase = Supabase.instance.client;

  Future<List<Vendor>> getAllVendors() async {
    try {
      final response = await supabase
          .from('vendors')
          .select('id , title , logo_url , category ');

      final vendors = await Future.wait(
        (response as List<dynamic>).map((row) async {
          final reviewsResponse = await supabase
              .from('reviews')
              .select('id, rating, target_type, target_id')
              .eq('target_id', row['id'])
              .eq('target_type', 'vendor')
              .maybeSingle();

          return Vendor.fromJson({...row, 'reviews': reviewsResponse});
        }),
      );

      return vendors;
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }
}
