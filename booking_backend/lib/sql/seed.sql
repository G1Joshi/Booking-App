INSERT INTO users (
        id,
        name,
        email,
        password,
        profile_image,
        phone,
        date_of_birth,
        city,
        state,
        country,
        pincode
    )
VALUES (
        '1001',
        'John Doe',
        'john@example.com',
        'password123',
        'https://picsum.photos/200',
        1234567890,
        '1990-01-01',
        'Mumbai',
        'Maharashtra',
        'India',
        400001
    ),
    (
        '1002',
        'Jane Smith',
        'jane@example.com',
        'password123',
        'https://picsum.photos/201',
        1234567891,
        '1985-05-12',
        'Delhi',
        'Delhi',
        'India',
        110001
    ),
    (
        '1003',
        'Alice Brown',
        'alice@example.com',
        'password123',
        'https://picsum.photos/202',
        1234567892,
        '1992-03-23',
        'Bangalore',
        'Karnataka',
        'India',
        560001
    ),
    (
        '1004',
        'Bob White',
        'bob@example.com',
        'password123',
        'https://picsum.photos/203',
        1234567893,
        '1988-07-14',
        'Chennai',
        'Tamil Nadu',
        'India',
        600001
    ),
    (
        '1005',
        'Charlie Black',
        'charlie@example.com',
        'password123',
        'https://picsum.photos/204',
        1234567894,
        '1995-11-30',
        'Kolkata',
        'West Bengal',
        'India',
        700001
    ),
    (
        '1006',
        'Daisy Green',
        'daisy@example.com',
        'password123',
        'https://picsum.photos/205',
        1234567895,
        '1991-09-19',
        'Pune',
        'Maharashtra',
        'India',
        411001
    ),
    (
        '1007',
        'Ethan Blue',
        'ethan@example.com',
        'password123',
        'https://picsum.photos/206',
        1234567896,
        '1987-02-28',
        'Hyderabad',
        'Telangana',
        'India',
        500001
    ),
    (
        '1008',
        'Fiona Red',
        'fiona@example.com',
        'password123',
        'https://picsum.photos/207',
        1234567897,
        '1993-06-15',
        'Ahmedabad',
        'Gujarat',
        'India',
        380001
    ),
    (
        '1009',
        'George Yellow',
        'george@example.com',
        'password123',
        'https://picsum.photos/208',
        1234567898,
        '1989-12-05',
        'Jaipur',
        'Rajasthan',
        'India',
        302001
    ),
    (
        '1010',
        'Hannah Purple',
        'hannah@example.com',
        'password123',
        'https://picsum.photos/209',
        1234567899,
        '1994-04-22',
        'Lucknow',
        'Uttar Pradesh',
        'India',
        226001
    );
INSERT INTO hotels (
        id,
        name,
        description,
        property_type,
        chain,
        star,
        rating,
        rooms_starting_price,
        cover_image
    )
VALUES (
        2001,
        'Hotel Paradise',
        'A luxury hotel in Mumbai',
        'Hotel',
        'Tata',
        5,
        4.5,
        5000,
        'https://picsum.photos/300'
    ),
    (
        2002,
        'Resort Bliss',
        'Beachside resort',
        'Resort',
        'Ambani',
        4,
        4.2,
        6000,
        'https://picsum.photos/301'
    ),
    (
        2003,
        'Apartment Elite',
        'Modern apartments',
        'Apartment',
        'Adani',
        3,
        3.8,
        4000,
        'https://picsum.photos/302'
    ),
    (
        2004,
        'Homestay Comfort',
        'Cozy homestay',
        'Homestay',
        'Birla',
        4,
        4.0,
        3500,
        'https://picsum.photos/303'
    ),
    (
        2005,
        'Villa Grandeur',
        'Luxurious villa',
        'Villa',
        'Roy',
        5,
        4.7,
        8000,
        'https://picsum.photos/304'
    ),
    (
        2006,
        'Hotel Urban',
        'City center hotel',
        'Hotel',
        'Tata',
        3,
        3.9,
        4500,
        'https://picsum.photos/305'
    ),
    (
        2007,
        'Resort Oasis',
        'Desert resort',
        'Resort',
        'Ambani',
        4,
        4.3,
        6200,
        'https://picsum.photos/306'
    ),
    (
        2008,
        'Apartment Prime',
        'Premium apartments',
        'Apartment',
        'Adani',
        3,
        3.7,
        4200,
        'https://picsum.photos/307'
    ),
    (
        2009,
        'Homestay Cozy',
        'Family homestay',
        'Homestay',
        'Birla',
        4,
        4.1,
        3600,
        'https://picsum.photos/308'
    ),
    (
        2010,
        'Villa Serenity',
        'Peaceful villa',
        'Villa',
        'Roy',
        5,
        4.8,
        8500,
        'https://picsum.photos/309'
    );
INSERT INTO details (
        amenities,
        rules,
        preferences,
        hotel_images,
        hotel_id
    )
VALUES (
        ARRAY ['Restaurant', 'Pool', 'Bar'],
        ARRAY ['No Smoking', 'No Pets', 'No Alcohol'],
        ARRAY ['Vegetarian', 'Non-vegetarian', 'Vegan'],
        ARRAY ['https://picsum.photos/310', 'https://picsum.photos/310', 'https://picsum.photos/310'],
        2001
    ),
    (
        ARRAY ['Bar', 'Spa', 'Gym'],
        ARRAY ['No Pets', 'No Smoking', 'Security Money'],
        ARRAY ['Non-vegetarian', 'Vegetarian', 'Bed Tea'],
        ARRAY ['https://picsum.photos/311', 'https://picsum.photos/311', 'https://picsum.photos/311'],
        2002
    ),
    (
        ARRAY ['Gym', 'Wifi', 'Laundry'],
        ARRAY ['24 Hour Cancellation', 'No Alcohol', 'No Smoking'],
        ARRAY ['Vegan', 'Evening Snacks', 'Vegetarian'],
        ARRAY ['https://picsum.photos/312', 'https://picsum.photos/312', 'https://picsum.photos/312'],
        2003
    ),
    (
        ARRAY ['Laundry', 'Parking', 'Pool'],
        ARRAY ['No Alcohol', 'No Pets', 'No Smoking'],
        ARRAY ['Bed Tea', 'Vegetarian', 'Non-vegetarian'],
        ARRAY ['https://picsum.photos/313', 'https://picsum.photos/313', 'https://picsum.photos/313'],
        2004
    ),
    (
        ARRAY ['Pool', 'Restaurant', 'Spa'],
        ARRAY ['Security Money', 'No Smoking', 'No Pets'],
        ARRAY ['Evening Snacks', 'Vegan', 'Bed Tea'],
        ARRAY ['https://picsum.photos/314', 'https://picsum.photos/314', 'https://picsum.photos/314'],
        2005
    ),
    (
        ARRAY ['Spa', 'Bar', 'Wifi'],
        ARRAY ['No Smoking', 'No Alcohol', 'No Pets'],
        ARRAY ['Vegetarian', 'Non-vegetarian', 'Vegan'],
        ARRAY ['https://picsum.photos/315', 'https://picsum.photos/315', 'https://picsum.photos/315'],
        2006
    ),
    (
        ARRAY ['Wifi', 'Gym', 'Parking'],
        ARRAY ['No Pets', 'No Smoking', 'Security Money'],
        ARRAY ['Non-vegetarian', 'Vegetarian', 'Bed Tea'],
        ARRAY ['https://picsum.photos/316', 'https://picsum.photos/316', 'https://picsum.photos/316'],
        2007
    ),
    (
        ARRAY ['Parking', 'Laundry', 'Pool'],
        ARRAY ['24 Hour Cancellation', 'No Alcohol', 'No Smoking'],
        ARRAY ['Vegan', 'Evening Snacks', 'Vegetarian'],
        ARRAY ['https://picsum.photos/317', 'https://picsum.photos/317', 'https://picsum.photos/317'],
        2008
    ),
    (
        ARRAY ['Restaurant', 'Pool', 'Bar'],
        ARRAY ['No Alcohol', 'No Pets', 'No Smoking'],
        ARRAY ['Bed Tea', 'Vegetarian', 'Non-vegetarian'],
        ARRAY ['https://picsum.photos/318', 'https://picsum.photos/318', 'https://picsum.photos/318'],
        2009
    ),
    (
        ARRAY ['Spa', 'Bar', 'Wifi'],
        ARRAY ['Security Money', 'No Smoking', 'No Pets'],
        ARRAY ['Evening Snacks', 'Vegan', 'Bed Tea'],
        ARRAY ['https://picsum.photos/319', 'https://picsum.photos/319', 'https://picsum.photos/319'],
        2010
    );
INSERT INTO address (
        street,
        city,
        state,
        country,
        pincode,
        latitude,
        longitude,
        hotel_id
    )
VALUES (
        'Marine Drive',
        'Mumbai',
        'Maharashtra',
        'India',
        400001,
        18.944,
        72.823,
        2001
    ),
    (
        'Juhu Beach',
        'Mumbai',
        'Maharashtra',
        'India',
        400049,
        19.098,
        72.826,
        2002
    ),
    (
        'MG Road',
        'Bangalore',
        'Karnataka',
        'India',
        560001,
        12.975,
        77.605,
        2003
    ),
    (
        'T Nagar',
        'Chennai',
        'Tamil Nadu',
        'India',
        600017,
        13.033,
        80.233,
        2004
    ),
    (
        'Salt Lake',
        'Kolkata',
        'West Bengal',
        'India',
        700091,
        22.585,
        88.417,
        2005
    ),
    (
        'FC Road',
        'Pune',
        'Maharashtra',
        'India',
        411004,
        18.523,
        73.841,
        2006
    ),
    (
        'Banjara Hills',
        'Hyderabad',
        'Telangana',
        'India',
        500034,
        17.412,
        78.441,
        2007
    ),
    (
        'SG Highway',
        'Ahmedabad',
        'Gujarat',
        'India',
        380015,
        23.043,
        72.546,
        2008
    ),
    (
        'MI Road',
        'Jaipur',
        'Rajasthan',
        'India',
        302001,
        26.912,
        75.787,
        2009
    ),
    (
        'Hazratganj',
        'Lucknow',
        'Uttar Pradesh',
        'India',
        226001,
        26.853,
        80.946,
        2010
    );
INSERT INTO contact (phone, email, website, hotel_id)
VALUES (
        1234567890,
        'contact@paradise.com',
        'www.paradise.com',
        2001
    ),
    (
        1234567891,
        'info@bliss.com',
        'www.bliss.com',
        2002
    ),
    (
        1234567892,
        'hello@elite.com',
        'www.elite.com',
        2003
    ),
    (
        1234567893,
        'stay@comfort.com',
        'www.comfort.com',
        2004
    ),
    (
        1234567894,
        'luxury@grandeur.com',
        'www.grandeur.com',
        2005
    ),
    (
        1234567895,
        'urban@hotel.com',
        'www.urbanhotel.com',
        2006
    ),
    (
        1234567896,
        'oasis@resort.com',
        'www.oasisresort.com',
        2007
    ),
    (
        1234567897,
        'prime@apartment.com',
        'www.primeapartment.com',
        2008
    ),
    (
        1234567898,
        'cozy@homestay.com',
        'www.cozyhomestay.com',
        2009
    ),
    (
        1234567899,
        'serenity@villa.com',
        'www.serenityvilla.com',
        2010
    );
INSERT INTO reviews (rating, review, guest_images, hotel_id, user_id)
VALUES (
        4.5,
        'Great stay!',
        ARRAY ['https://picsum.photos/320'],
        2001,
        '1001'
    ),
    (
        4.2,
        'Loved the beach view.',
        ARRAY ['https://picsum.photos/321'],
        2002,
        '1002'
    ),
    (
        3.8,
        'Nice apartments.',
        ARRAY ['https://picsum.photos/322'],
        2003,
        '1003'
    ),
    (
        4.0,
        'Cozy and comfortable.',
        ARRAY ['https://picsum.photos/323'],
        2004,
        '1004'
    ),
    (
        4.7,
        'Luxurious experience.',
        ARRAY ['https://picsum.photos/324'],
        2005,
        '1005'
    ),
    (
        3.9,
        'Good location.',
        ARRAY ['https://picsum.photos/325'],
        2006,
        '1006'
    ),
    (
        4.3,
        'Desert adventure!',
        ARRAY ['https://picsum.photos/326'],
        2007,
        '1007'
    ),
    (
        3.7,
        'Premium feel.',
        ARRAY ['https://picsum.photos/327'],
        2008,
        '1008'
    ),
    (
        4.1,
        'Family friendly.',
        ARRAY ['https://picsum.photos/328'],
        2009,
        '1009'
    ),
    (
        4.8,
        'Peaceful and serene.',
        ARRAY ['https://picsum.photos/329'],
        2010,
        '1010'
    );
INSERT INTO rooms (
        category,
        description,
        price,
        count,
        capacity,
        amenities,
        room_images,
        hotel_id
    )
VALUES (
        'Deluxe Room',
        'Spacious room with sea view',
        7000,
        10,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/330'],
        2001
    ),
    (
        'Suite Room',
        'Luxury suite with balcony',
        12000,
        5,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/330a'],
        2001
    ),
    (
        'Standard Room',
        'Affordable comfort',
        4000,
        20,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/330b'],
        2001
    ),
    (
        'Deluxe Room',
        'Sea view room',
        8000,
        8,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/331'],
        2002
    ),
    (
        'Suite Room',
        'Luxury suite',
        13000,
        4,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/331a'],
        2002
    ),
    (
        'Standard Room',
        'Comfortable stay',
        5000,
        15,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/331b'],
        2002
    ),
    (
        'Deluxe Room',
        'Modern room',
        6000,
        12,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/332'],
        2003
    ),
    (
        'Suite Room',
        'Spacious suite',
        11000,
        6,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/332a'],
        2003
    ),
    (
        'Standard Room',
        'Budget option',
        3500,
        18,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/332b'],
        2003
    ),
    (
        'Executive Room',
        'Business class amenities',
        9000,
        8,
        3,
        ARRAY ['AC', 'Iron'],
        ARRAY ['https://picsum.photos/333'],
        2004
    ),
    (
        'Family Room',
        'Perfect for families',
        8000,
        6,
        5,
        ARRAY ['Wifi', 'Hairdryer'],
        ARRAY ['https://picsum.photos/333a'],
        2004
    ),
    (
        'Standard Room',
        'Affordable comfort',
        4000,
        20,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/333b'],
        2004
    ),
    (
        'Deluxe Room',
        'Luxury room',
        10000,
        9,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/334'],
        2005
    ),
    (
        'Suite Room',
        'Premium suite',
        15000,
        3,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/334a'],
        2005
    ),
    (
        'Family Room',
        'Family stay',
        9000,
        7,
        5,
        ARRAY ['Wifi', 'Hairdryer'],
        ARRAY ['https://picsum.photos/334b'],
        2005
    ),
    (
        'Accessible Room',
        'Wheelchair accessible',
        6000,
        4,
        2,
        ARRAY ['Telephone', 'Heating'],
        ARRAY ['https://picsum.photos/335'],
        2006
    ),
    (
        'Deluxe Room',
        'Premium comfort',
        8500,
        7,
        2,
        ARRAY ['AC', 'Geyser'],
        ARRAY ['https://picsum.photos/335a'],
        2006
    ),
    (
        'Standard Room',
        'Budget friendly',
        3500,
        15,
        2,
        ARRAY ['Wifi', 'Iron'],
        ARRAY ['https://picsum.photos/335b'],
        2006
    ),
    (
        'Pet-Friendly Room',
        'Bring your pets!',
        7500,
        3,
        2,
        ARRAY ['Wifi', 'Safe'],
        ARRAY ['https://picsum.photos/336'],
        2007
    ),
    (
        'Deluxe Room',
        'Comfortable room',
        7000,
        10,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/336a'],
        2007
    ),
    (
        'Suite Room',
        'Luxury suite',
        12000,
        5,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/336b'],
        2007
    ),
    (
        'Deluxe Room',
        'Premium comfort',
        8500,
        7,
        2,
        ARRAY ['AC', 'Geyser'],
        ARRAY ['https://picsum.photos/337'],
        2008
    ),
    (
        'Suite Room',
        'Spacious suite',
        13000,
        2,
        4,
        ARRAY ['Television', 'Wifi'],
        ARRAY ['https://picsum.photos/337a'],
        2008
    ),
    (
        'Standard Room',
        'Budget friendly',
        3500,
        15,
        2,
        ARRAY ['Wifi', 'Iron'],
        ARRAY ['https://picsum.photos/337b'],
        2008
    ),
    (
        'Deluxe Room',
        'Sea view room',
        8000,
        8,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/338'],
        2009
    ),
    (
        'Suite Room',
        'Luxury suite',
        13000,
        4,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/338a'],
        2009
    ),
    (
        'Standard Room',
        'Comfortable stay',
        5000,
        15,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/338b'],
        2009
    ),
    (
        'Deluxe Room',
        'Peaceful room',
        9000,
        9,
        2,
        ARRAY ['Wifi', 'AC'],
        ARRAY ['https://picsum.photos/339'],
        2010
    ),
    (
        'Suite Room',
        'Serene suite',
        14000,
        3,
        4,
        ARRAY ['Television', 'Safe'],
        ARRAY ['https://picsum.photos/339a'],
        2010
    ),
    (
        'Standard Room',
        'Budget option',
        4000,
        18,
        2,
        ARRAY ['Wifi', 'Geyser'],
        ARRAY ['https://picsum.photos/339b'],
        2010
    );
INSERT INTO bookings (
        status,
        booking_date,
        checkin,
        checkout,
        rooms,
        guests,
        room_id,
        user_id
    )
VALUES (
        'Confirmed',
        '2024-06-01',
        '2024-06-10',
        '2024-06-15',
        1,
        2,
        1,
        '1001'
    ),
    (
        'Pending',
        '2024-06-02',
        '2024-06-12',
        '2024-06-17',
        2,
        4,
        2,
        '1002'
    ),
    (
        'Cancelled',
        '2024-06-03',
        '2024-06-14',
        '2024-06-19',
        1,
        1,
        3,
        '1003'
    ),
    (
        'Confirmed',
        '2024-06-04',
        '2024-06-16',
        '2024-06-21',
        3,
        6,
        4,
        '1004'
    ),
    (
        'Pending',
        '2024-06-05',
        '2024-06-18',
        '2024-06-23',
        2,
        3,
        5,
        '1005'
    ),
    (
        'Confirmed',
        '2024-06-06',
        '2024-06-20',
        '2024-06-25',
        1,
        2,
        6,
        '1006'
    ),
    (
        'Cancelled',
        '2024-06-07',
        '2024-06-22',
        '2024-06-27',
        2,
        4,
        7,
        '1007'
    ),
    (
        'Confirmed',
        '2024-06-08',
        '2024-06-24',
        '2024-06-29',
        1,
        1,
        8,
        '1008'
    ),
    (
        'Pending',
        '2024-06-09',
        '2024-06-26',
        '2024-07-01',
        3,
        5,
        9,
        '1009'
    ),
    (
        'Confirmed',
        '2024-06-10',
        '2024-06-28',
        '2024-07-03',
        2,
        2,
        10,
        '1010'
    );
INSERT INTO localities (name, latitude, longitude)
VALUES ('Colaba', 18.910, 72.814),
    ('Juhu', 19.098, 72.826),
    ('MG Road', 12.975, 77.605),
    ('T Nagar', 13.033, 80.233),
    ('Salt Lake', 22.585, 88.417),
    ('FC Road', 18.523, 73.841),
    ('Banjara Hills', 17.412, 78.441),
    ('SG Highway', 23.043, 72.546),
    ('MI Road', 26.912, 75.787),
    ('Hazratganj', 26.853, 80.946);