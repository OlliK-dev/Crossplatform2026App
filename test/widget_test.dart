import 'package:crossplatform2026project/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Like button adds word to favorites", (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Like"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Favorites"));
    await tester.pumpAndSettle();

    expect(find.text("No favorites yet."), findsNothing);
  });
}
