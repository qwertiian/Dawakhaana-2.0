import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signInWithOtp({String? email, String? phone}) async {
    try {
      if (email != null) {
        await _supabase.auth.signInWithOtp(
          email: email,
          emailRedirectTo: 'io.supabase.flutter://signin-callback/',
        );
      } else if (phone != null) {
        await _supabase.auth.signInWithOtp(phone: phone);
      } else {
        throw Exception('Either email or phone must be provided.');
      }
    } catch (e) {
      throw Exception('OTP sign-in failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? get currentUser => _supabase.auth.currentUser;
}
