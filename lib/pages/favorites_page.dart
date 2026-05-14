import 'package:crossplatform2026project/viewmodels/app_state.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override 
  State<FavoritesPage> createState() => _FavoritesPageState();

}

class _FavoritesPageState extends State<FavoritesPage> {
  final selectedFavorites = <WordPair>{};
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet."));
    }

    selectedFavorites.removeWhere(
      (pair) => !appState.favorites.contains(pair),
    );

    return ListView (
      children: [
        Padding(padding: const EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: selectedFavorites.isEmpty
          ? null
          : () async {
            final messenger = ScaffoldMessenger.of(context);
            final word = selectedFavorites.toList();

            try {
              await appState.sendSelectedToSupabase(word);

              setState(() {
                selectedFavorites.clear();
              });
              
              messenger.showSnackBar(
                SnackBar(content: Text(
                  "Sent ${word.length} favorites to Supabase"
                ),
                ),
              );
            } catch (error) {
              messenger.showSnackBar(
                SnackBar(content: Text(error.toString())),
              );
              debugPrint(error.toString());
            }
          },
          icon: Icon(Icons.announcement_sharp),
          label: Text("Send selected"),
          ),
        ),
        for (var pair in appState.favorites)
        CheckboxListTile(
          value: selectedFavorites.contains(pair),
          onChanged: (value) {
            setState(() {
              if (value == true) {
                selectedFavorites.add(pair);
              } else {
                selectedFavorites.remove(pair);
              }
            });
          },
          secondary: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              setState(() {
                selectedFavorites.remove(pair);
              });
              appState.removeFavorite(pair);
              debugPrint("Removed from favorites");
            },
          ),
          title: Text(pair.asLowerCase),
        ),
      ],
    );

  }
}
