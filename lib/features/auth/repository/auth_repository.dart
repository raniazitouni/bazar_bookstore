import 'package:bazar_bookstore/features/auth/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(
    String email,
    String password,
    String name,
  ) async {
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user != null) {
      // Insert into your custom users table
      await supabase.from('users').insert({'id': user.id, 'name': name , 'email': email});
    }

    return response;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<UserModel?> getUser() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return null;

      final response = await supabase
          .from('users')
          .select('id , name , phone_number , picture_url , email')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) return null;

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch the user : $e');
    }
  }

  Session? get currentSession => supabase.auth.currentSession;
}
