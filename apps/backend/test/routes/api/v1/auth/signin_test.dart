import 'dart:io';

import 'package:booking_backend/service/auth_service.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../routes/api/v1/auth/signin.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockAuthService extends Mock implements AuthService {}

class MockRequest extends Mock implements Request {}

class FakeLoginRequest extends Fake implements LoginRequest {}

void main() {
  group('POST /signin', () {
    late RequestContext context;
    late AuthService authService;
    late Request request;

    setUpAll(() => registerFallbackValue(FakeLoginRequest()));

    setUp(() {
      context = MockRequestContext();
      authService = MockAuthService();
      request = MockRequest();
      when(() => context.read<AuthService>()).thenReturn(authService);
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
    });

    test('returns 201 and token', () async {
      when(
        () => request.json(),
      ).thenAnswer((_) async => {'email': 'e', 'password': 'p'});
      when(
        () => authService.read(any()),
      ).thenAnswer((_) async => const Token(accessToken: 'tk'));
      final response = await route.onRequest(context);
      expect(response.statusCode, HttpStatus.created);
      final body = await response.json() as Map<String, dynamic>;
      final data = body['data'] as Map<String, dynamic>;
      expect(data['access_token'], 'tk');
    });

    test('returns 203 if not found', () async {
      when(
        () => request.json(),
      ).thenAnswer((_) async => {'email': 'e', 'password': 'p'});
      when(() => authService.read(any())).thenAnswer((_) async => null);
      expect(
        (await route.onRequest(context)).statusCode,
        HttpStatus.nonAuthoritativeInformation,
      );
    });

    test('returns 405 on GET', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      expect(
        (await route.onRequest(context)).statusCode,
        HttpStatus.methodNotAllowed,
      );
    });
  });
}
