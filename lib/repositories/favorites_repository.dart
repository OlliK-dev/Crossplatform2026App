
import 'package:crossplatform2026project/models/favorite_word.dart';
import 'package:crossplatform2026project/services/favorites_service.dart';
import 'package:english_words/english_words.dart';

class FavoritesRepository {
  FavoritesRepository(this._service);

  final FavoritesService _service;

  Future<void> sendFavorites(List<WordPair> words) async {
    final favorites = words
        .map((pair) => FavoriteWord(word: pair.asLowerCase).toJson())
        .toList();

    await _service.sendFavorites(favorites);
  }
}
