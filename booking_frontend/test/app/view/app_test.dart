import 'package:booking_frontend/app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    setUp(() async {
      await dotenv.load();
    });

    testWidgets('renders AuthPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AuthPage), findsOneWidget);
    });
  });
}
