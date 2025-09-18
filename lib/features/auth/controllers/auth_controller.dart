import 'dart:async';
import 'package:bazar_bookstore/features/auth/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bazar_bookstore/features/auth/providers/auth_provider.dart';

class AuthController extends AsyncNotifier<Session?> {
  @override
  FutureOr<Session?> build() {
    //current Supabase session
    final repo = ref.read(authRepositoryProvider);
    return repo.currentSession;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final res = await repo.signIn(email, password);
      return res.session;
    });
  }

  Future<void> signUp(String email, String password , String name) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final res = await repo.signUp(email, password,name);
      return res.session;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      await repo.signOut();
      return null; //no session
    });
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, Session?>(
  AuthController.new,
);
