import 'package:booking_backend/models/models.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:booking_backend/service/room_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:faker/faker.dart' as fake;

class Seed {
  static fake.RandomGenerator random = fake.RandomGenerator();
  static fake.Faker faker = fake.Faker.withGenerator(random);

  static Future<void> createFakeHotels(RequestContext context) async {
    for (var i = 1; i <= 1000; i++) {
      final id = random.integer(1000000000, min: 1000);
      await context.read<HotelService>().create(
            Hotel(
              name: faker.company.name(),
              description: faker.lorem.sentence(),
              property_type: random.fromPattern([
                'Hotel',
                'Resort',
                'Apartment',
                'Homestay',
                'Villa',
              ]),
              chain: random.fromPattern([
                'Tata',
                'Ambani',
                'Adani',
                'Birla',
                'Roy',
              ]),
              star: random.integer(6, min: 1),
              rating: random.integer(6, min: 1),
              rooms_starting_price: random.integer(50000, min: 1000),
              cover_image: faker.image.image(),
              address: Address(
                street: faker.address.streetName(),
                city: faker.address.city(),
                state: faker.address.state(),
                country: faker.address.country(),
                pincode: random.integer(999999, min: 100000),
                latitude: faker.geo.latitude(),
                longitude: faker.geo.longitude(),
              ),
              contact: Contact(
                phone: random.integer(4444444444, min: 1000000000),
                email: faker.internet.email(),
                website: faker.internet.domainName(),
              ),
              details: Details(
                amenities: List.generate(
                  3,
                  (index) => random.fromPattern([
                    'Restaurant',
                    'Bar',
                    'Gym',
                    'Spa',
                    'Pool',
                    'Wifi',
                    'Laundry',
                    'Parking',
                    'Pool',
                  ]),
                ),
                rules: List.generate(
                  2,
                  (index) => random.fromPattern([
                    '24 Hour Cancellation',
                    'No Smoking',
                    'No Pets',
                    'No Alcohol',
                    'Security Money',
                  ]),
                ),
                preferences: List.generate(
                  2,
                  (index) => random.fromPattern([
                    'Non-vegetarian',
                    'Vegetarian',
                    'Vegan',
                    'Bed Tea',
                    'Evening Snacks',
                  ]),
                ),
                hotel_images: List.generate(4, (index) => faker.image.image()),
              ),
            ),
            id,
          );
      await createFakeRooms(context, id.toString());
    }
  }

  static Future<void> createFakeRooms(
    RequestContext context,
    String hotelId,
  ) async {
    for (var i = 1; i <= 3; i++) {
      await context.read<RoomService>().create(
            Room(
              category: random.fromPattern([
                'Standard Room',
                'Suite Room',
                'Deluxe Room',
                'Executive Room',
                'Family Room',
                'Accessible Room',
                'Pet-Friendly Room',
              ]),
              description: faker.lorem.sentence(),
              price: random.integer(50000, min: 1000),
              count: random.integer(500, min: 100),
              capacity: random.integer(5, min: 1),
              amenities: List.generate(
                3,
                (index) => random.fromPattern([
                  'Television',
                  'Telephone',
                  'Wifi',
                  'AC',
                  'Heating',
                  'Hairdryer',
                  'Geyser',
                  'Safe',
                  'Iron'
                ]),
              ),
              room_images: List.generate(4, (index) => faker.image.image()),
            ),
            hotelId,
          );
    }
  }
}
