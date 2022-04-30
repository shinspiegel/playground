CREATE TABLE IF NOT EXISTS denoUsers (
  id uuid DEFAULT uuid_generate_v4 (),
  name VARCHAR,
  email VARCHAR,
  isActive BOOLEAN
)