import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazar_bookstore/features/auth/providers/auth_provider.dart';
import 'package:bazar_bookstore/features/auth/models/user_model.dart';

class UserController extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() async {
    final repo = ref.read(authRepositoryProvider);
    return await repo.getUser(); 
  }

  Future<void> refreshUser() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      return await repo.getUser();
    });
  }
}

final userControllerProvider =
    AsyncNotifierProvider<UserController, UserModel?>(UserController.new);
