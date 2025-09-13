
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/features/auth/repository/auth_repository.dart';



final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// password visibility
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
