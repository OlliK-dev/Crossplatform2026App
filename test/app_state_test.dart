import 'package:flutter_test/flutter_test.dart';
import 'package:crossplatform2026project/repositories/favorites_repository.dart';
import 'package:crossplatform2026project/services/favorites_service.dart';
import 'package:crossplatform2026project/viewmodels/app_state.dart';

void main() {
  test("toggleFavorite adds current word to favorites", () {
    final appState = MyAppState(FavoritesRepository(FavoritesService()));

    final current = appState.current;

    appState.toggleFavorite();

    expect(appState.favorites, contains(current));
  });
}
