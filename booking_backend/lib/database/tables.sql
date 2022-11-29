CREATE TABLE IF NOT EXISTS hotels (
  id uuid NOT NULL,
  name text NOT NULL,
  phone bigint NOT NULL,
  email text NOT NULL,
  address text NOT NULL,
  pincode bigint NOT NULL,
  city text NOT NULL,
  country text NOT NULL,
  rooms integer NOT NULL,
  rating integer NOT NULL
);