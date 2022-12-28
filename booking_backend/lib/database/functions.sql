CREATE OR REPLACE FUNCTION distance(lat1 REAL, lon1 REAL, lat2 REAL, lon2 REAL) RETURNS REAL AS $$
DECLARE x REAL = 69.1 * (lat2 - lat1);
y REAL = 69.1 * (lon2 - lon1) * cos(lat1 / 57.3);
BEGIN RETURN sqrt(x * x + y * y);
END $$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION update_hotel_rating() RETURNS TRIGGER AS $$ BEGIN
UPDATE hotels
SET rating = (
        SELECT AVG(rating)
        FROM reviews
        WHERE hotel_id = NEW.hotel_id
    )
WHERE id = NEW.hotel_id;
RETURN NEW;
END $$ LANGUAGE plpgsql;