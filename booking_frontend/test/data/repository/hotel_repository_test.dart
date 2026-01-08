import 'package:booking_frontend/data/client/client.dart';
import 'package:booking_frontend/data/repository/hotel_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('HotelRepository Tests', () {
    late HotelRepository hotelRepository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      hotelRepository = HotelRepository(client: mockClient);
    });

    final hotelData = {
      'id': 1,
      'name': 'Grand Plaza',
      'description': 'A luxury hotel',
      'property_type': 'Hotel',
      'chain': 'Grand',
      'star': 5,
      'rating': 4.5,
      'rooms_starting_price': 200,
      'cover_image': 'cover.png',
    };

    test('readAll returns hotels', () async {
      when(() => mockClient.get(path: any(named: 'path'))).thenAnswer(
        (_) async => {
          'status': true,
          'data': [hotelData],
        },
      );

      final res = await hotelRepository.readAll();
      expect(res.first.name, 'Grand Plaza');
    });

    test('read returns hotel', () async {
      when(
        () => mockClient.get(path: any(named: 'path')),
      ).thenAnswer((_) async => {'status': true, 'data': hotelData});

      expect((await hotelRepository.read(1)).name, 'Grand Plaza');
    });

    test('addReview returns true', () async {
      when(
        () => mockClient.post(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => {'status': true});

      expect(await hotelRepository.addReview(1, 4, 'ok'), true);
    });

    test('search returns hotels', () async {
      when(
        () => mockClient.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'status': true,
          'data': [hotelData],
        },
      );

      final res = await hotelRepository.search('NY', 1, '1', '2', 1);
      expect(res.first.name, 'Grand Plaza');
    });

    test('filter returns hotels', () async {
      when(
        () => mockClient.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => {
          'status': true,
          'data': [hotelData],
        },
      );

      final res = await hotelRepository.filter('5', '4', 'H', '100');
      expect(res.first.name, 'Grand Plaza');
    });
  });
}
