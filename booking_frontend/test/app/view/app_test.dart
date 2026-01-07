import 'package:booking_frontend/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders AuthPage', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(AuthPage), findsOneWidget);
    });
  });
}
