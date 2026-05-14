class FavoriteWord {
  const FavoriteWord ({
    required this.word,
  });

  final String word;

  Map<String, String> toJson() {
    return {
      "word": word,
    };
  }
}