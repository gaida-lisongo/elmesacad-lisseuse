import 'package:flutter_test/flutter_test.dart';
import 'package:liseuse_elmes/main.dart';

void main() {
  testWidgets('Application démarre sur la bibliothèque', (tester) async {
    await tester.pumpWidget(const LiseuseApp());
    await tester.pump();

    expect(find.text('Bibliothèque'), findsOneWidget);
  });
}
