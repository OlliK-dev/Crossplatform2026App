import 'dart:convert';

import 'package:http/http.dart' as http;

class FavoritesService {
  static const _supabaseUrl = 'https://dezcydunjqmzzaismolb.supabase.co';
  static const _supabaseApiKey = 'sb_publishable_d07dabsRnrLR3eBVIn9t2g_u69Pax0d';
  static const _favoritesTable = 'favorites';

  
  Future<void> sendFavorites(List<Map<String, String>> favorites) async {
    final url = Uri.parse('$_supabaseUrl/rest/v1/$_favoritesTable');

    final response = await http.post(
      url,
      headers: {
        'apikey': _supabaseApiKey,
        'Authorization': 'Bearer $_supabaseApiKey',
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal',
      },
      body: jsonEncode(favorites),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Failed to send favorites (${response.statusCode}): ${response.body}',
      );
    }
  }
}
