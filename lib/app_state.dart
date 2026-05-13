import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const _supabaseUrl = 'https://dezcydunjqmzzaismolb.supabase.co';
const _supabaseApiKey = 'sb_publishable_d07dabsRnrLR3eBVIn9t2g_u69Pax0d';
const _favoritesTable = 'favorites';
const _favoriteColumn = 'word';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
      debugPrint("Item removed from favorites");
    } else {
      favorites.add(current);
      debugPrint("Item added to favorites");
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  Future<void> sendFavoriteToSupabase(String word) async {
    await _postFavorites([
      {_favoriteColumn: word},
    ]);
  }

  Future<void> sendSelectedToSupabase(List<WordPair> word) async {
    await _postFavorites(
      word.map((pair) {
        return {_favoriteColumn: pair.asLowerCase};
      }).toList(),
    );

    favorites.removeWhere((pair) => word.contains(pair));
    notifyListeners();
  }

  Future<void> _postFavorites(List<Map<String, String>> favorites) async {
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
