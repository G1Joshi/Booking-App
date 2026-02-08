import 'package:booking_utils/booking_utils.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final grade = Grade.getGrade(5);

    setUp(() {});

    test('First Test', () {
      expect(grade, "Excellent");
    });
  });
}
