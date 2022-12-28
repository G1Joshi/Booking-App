CREATE TABLE if NOT EXISTS users (
    id NUMERIC PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    profile_image VARCHAR(255),
    phone BIGINT,
    date_of_birth DATE,
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    pincode BIGINT
);
CREATE TABLE if NOT EXISTS hotels (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    property_type VARCHAR(255),
    chain VARCHAR(255),
    star INTEGER,
    rating REAL,
    rooms_starting_price INTEGER,
    cover_image VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS details (
    id SERIAL PRIMARY KEY,
    amenities text [],
    rules text [],
    preferences text [],
    hotel_images text [],
    hotel_id INTEGER REFERENCES hotels (id)
);
ALTER TABLE details
ADD UNIQUE (hotel_id);
CREATE TABLE IF NOT EXISTS address (
    id SERIAL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    pincode BIGINT,
    latitude REAL,
    longitude REAL,
    hotel_id INTEGER REFERENCES hotels (id)
);
ALTER TABLE address
ADD UNIQUE (hotel_id);
CREATE TABLE IF NOT EXISTS contact (
    id SERIAL PRIMARY KEY,
    phone BIGINT,
    email VARCHAR(255),
    website VARCHAR(255),
    hotel_id INTEGER REFERENCES hotels (id)
);
ALTER TABLE contact
ADD UNIQUE (hotel_id);
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    rating REAL,
    review TEXT,
    guest_images text [],
    hotel_id INTEGER REFERENCES hotels (id),
    user_id NUMERIC REFERENCES users (id)
);
CREATE TABLE IF NOT EXISTS rooms (
    id SERIAL PRIMARY KEY,
    category VARCHAR(255),
    description text,
    price INTEGER,
    count INTEGER,
    capacity INTEGER,
    amenities text [],
    room_images text [],
    hotel_id INTEGER REFERENCES hotels (id)
);
CREATE TABLE IF NOT EXISTS bookings (
    id SERIAL PRIMARY KEY,
    status VARCHAR(255),
    booking_date DATE,
    checkin DATE,
    checkout DATE,
    rooms INTEGER,
    guests INTEGER,
    room_id INTEGER REFERENCES rooms (id),
    user_id NUMERIC REFERENCES users (id)
);
CREATE TABLE IF NOT EXISTS localities (
    id SERIAL PRIMARY KEY,
    name TEXT,
    latitude REAL,
    longitude REAL
);