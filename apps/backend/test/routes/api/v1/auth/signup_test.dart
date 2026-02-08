import 'dart:io';

import 'package:booking_backend/service/auth_service.dart';
import 'package:booking_models/booking_models.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../routes/api/v1/auth/signup.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockAuthService extends Mock implements AuthService {}

class MockRequest extends Mock implements Request {}

class FakeUser extends Fake implements User {}

void main() {
  group('POST /signup', () {
    late RequestContext context;
    late AuthService authService;
    late Request request;

    setUpAll(() => registerFallbackValue(FakeUser()));

    setUp(() {
      context = MockRequestContext();
      authService = MockAuthService();
      request = MockRequest();
      when(() => context.read<AuthService>()).thenReturn(authService);
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.post);
    });

    final fullUser = {
      'id': '1',
      'name': 'n',
      'email': 'e',
      'phone': 1,
      'city': 'c',
      'state': 's',
      'country': 'c',
      'pincode': 1,
      'date_of_birth': 'd',
    };

    test('returns 201 on success', () async {
      when(() => request.json()).thenAnswer((_) async => fullUser);
      when(() => authService.create(any())).thenAnswer((_) async => true);
      expect((await route.onRequest(context)).statusCode, HttpStatus.created);
    });

    test('returns 203 if exists', () async {
      when(() => request.json()).thenAnswer((_) async => fullUser);
      when(() => authService.create(any())).thenAnswer((_) async => false);
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
