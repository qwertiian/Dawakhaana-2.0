import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRealtime {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>> profileChanges(String userId) {
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId);
  }

  void dispose() {
    _supabase.removeAllChannels();
  }
}
