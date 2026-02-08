import 'package:booking_models/booking_models.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final token = Token(accessToken: "abc-xyz");

    setUp(() {});

    test('First Test', () {
      expect(token.accessToken, "abc-xyz");
    });
  });
}
