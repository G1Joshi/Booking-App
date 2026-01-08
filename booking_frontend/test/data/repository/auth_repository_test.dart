import 'package:booking_frontend/data/data.dart';
import 'package:booking_frontend/data/model/login_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('AuthRepository Tests', () {
    late AuthRepository authRepository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      authRepository = AuthRepository(client: mockClient);
    });

    final testUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123',
      phone: 1234567890,
      dateOfBirth: '1990-01-01',
      city: 'New York',
      state: 'NY',
      country: 'USA',
      pincode: 10001,
    );

    test('signUp returns true', () async {
      when(
        () => mockClient.post(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => {'status': true});

      expect(await authRepository.signUp(testUser), true);
    });

    test('signUp throws on failure', () async {
      when(
        () => mockClient.post(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => {'status': false, 'message': 'err'});

      expect(() => authRepository.signUp(testUser), throwsException);
    });

    test('signIn returns Token', () async {
      when(
        () => mockClient.post(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => {
          'status': true,
          'data': {'access_token': 'tk'},
        },
      );

      final res = await authRepository.signIn(
        LoginRequest(email: 'e', password: 'p'),
      );
      expect(res?.accessToken, 'tk');
    });
  });
}
