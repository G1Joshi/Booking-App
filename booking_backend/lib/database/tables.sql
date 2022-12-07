CREATE TABLE if NOT EXISTS hotels (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    property_type VARCHAR(255),
    chain VARCHAR(255),
    category VARCHAR(255),
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
CREATE TABLE IF NOT EXISTS booking (
    id SERIAL PRIMARY KEY,
    checkin DATE,
    checkout DATE,
    cancellation VARCHAR(255),
    hotel_id INTEGER REFERENCES hotels (id)
);
ALTER TABLE booking
ADD UNIQUE (hotel_id);
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    rating REAL,
    review VARCHAR(255),
    guest_images text [],
    hotel_id INTEGER REFERENCES hotels (id)
);
CREATE TABLE IF NOT EXISTS rooms (
    id SERIAL PRIMARY KEY,
    category VARCHAR(255),
    description text,
    price INTEGER,
    count INTEGER,
    occupancy INTEGER,
    amenities text [],
    room_images text [],
    hotel_id INTEGER REFERENCES hotels (id)
);