import 'package:booking_frontend/app/app.dart';
import 'package:booking_frontend/config/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('App', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await Storage.init();
    });

    testWidgets('renders AuthPage', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(AuthPage), findsOneWidget);
    });
  });
}
