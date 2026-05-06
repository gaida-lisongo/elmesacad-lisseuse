import 'package:flutter_test/flutter_test.dart';
import 'package:liseuse_elmes/app/router/app_router.dart';
import 'package:liseuse_elmes/main.dart';

void main() {
  testWidgets('Démarrage sur le splash ELMESACAD', (tester) async {
    final router = createAppRouter();
    await tester.pumpWidget(LiseuseApp(router: router));
    await tester.pump();

    expect(find.text('ELMESACAD'), findsOneWidget);
  });
}
