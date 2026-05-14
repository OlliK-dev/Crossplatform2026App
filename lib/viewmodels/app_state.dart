
import 'package:crossplatform2026project/repositories/favorites_repository.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  MyAppState(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  WordPair current = WordPair.random();

  final List<WordPair> favorites = [];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  Future<void> sendSelectedToSupabase(List<WordPair> words) async {
    await _favoritesRepository.sendFavorites(words);


    favorites.removeWhere((pair) => words.contains(pair));
    notifyListeners();
  }
}
