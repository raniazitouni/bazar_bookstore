import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authUserProvider = StreamProvider<User?>((ref) {
  final client = Supabase.instance.client;
  
  return client.auth.onAuthStateChange.map((data) => data.session?.user);
});
