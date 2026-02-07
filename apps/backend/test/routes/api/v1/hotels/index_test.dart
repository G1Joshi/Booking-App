import 'dart:io';

import 'package:booking_backend/service/hotels_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../../routes/api/v1/hotels/index.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockHotelService extends Mock implements HotelService {}

class MockRequest extends Mock implements Request {}

void main() {
  group('GET /api/v1/hotels', () {
    late RequestContext context;
    late HotelService hotelService;
    late Request request;

    setUp(() {
      context = MockRequestContext();
      hotelService = MockHotelService();
      request = MockRequest();

      when(() => context.read<HotelService>()).thenReturn(hotelService);
      when(() => context.request).thenReturn(request);
      when(() => request.method).thenReturn(HttpMethod.get);
    });

    test('GET returns 200 and hotels', () async {
      when(() => hotelService.readAll()).thenAnswer((_) async => []);
      final response = await route.onRequest(context);

      expect(response.statusCode, HttpStatus.ok);
    });

    test('invalid method returns 405', () async {
      when(() => request.method).thenReturn(HttpMethod.patch);
      final response = await route.onRequest(context);

      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });
  });
}
