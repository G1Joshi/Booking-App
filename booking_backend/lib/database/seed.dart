import 'package:booking_backend/models/hotels_model.dart';
import 'package:booking_backend/service/hotels_service.dart';
import 'package:faker/faker.dart' as fake;

class Seed {
  static fake.RandomGenerator random = fake.RandomGenerator();
  static fake.Faker faker = fake.Faker.withGenerator(random);

  static Future<void> createFakeHotels(HotelService hotelService) async {
    for (var i = 1; i <= 100; i++) {
      await hotelService.create(
        HotelsModel(
          hotel: Hotel(
            name: faker.company.name(),
            description: faker.lorem.sentence(),
            property_type: random.fromPattern(['Hotel', 'Resort', 'Inn']),
            chain: random.fromPattern(['Tata', 'Ambani', 'Adani']),
            star: random.integer(6),
            rating: random.integer(6),
            rooms_starting_price: random.integer(50000, min: 1000),
            cover_image: faker.image.image(),
          ),
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
                'Parking'
              ]),
            ),
            rules: List.generate(
              1,
              (index) =>
                  random.fromPattern(['No smoking', 'No pets', 'No Alcohol']),
            ),
            preferences: List.generate(
              1,
              (index) =>
                  random.fromPattern(['Non-vegetarian', 'Vegetarian', 'Vegan']),
            ),
            hotel_images: List.generate(3, (index) => faker.image.image()),
          ),
        ),
      );
    }
  }
}
