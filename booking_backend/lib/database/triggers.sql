CREATE OR REPLACE TRIGGER update_hotel_rating
AFTER
INSERT ON reviews FOR EACH ROW EXECUTE PROCEDURE update_hotel_rating();