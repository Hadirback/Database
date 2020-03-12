# Еще не закончено!

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50) IS NOT NULL,
  middlename VARCHAR(50),
  lastname VARCHAR(50),
  card_id BIGINT NOT NULL UNIQUE,
  email VARCHAR(120) UNIQUE NOT NULL,
  phone VARCHAR(12) NOT NULL,
  photo_id BIGINT,
  address VARCHAR(255) NOT NULL,
  created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX users_phone_idx(phone), 
  INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS cards;
CREATE TABLE cards (
  id SERIAL PRIMARY KEY,
  serial VARCHAR(50) IS NOT NULL,
  number VARCHAR(50),
  balance DECIMAL NOT NULL DEFAULT 0,
  pts_balance DECIMAL NOT NULL DEFAULT 0,
  is_blocked BIT NOT NULL DEFAULT 0,
  is_deleted BIT NOT NULL DEFAULT 0,
  registration_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,


);


DROP TABLE IF EXISTS photo_users;
CREATE TABLE photo_users (
  id SERIAL PRIMARY KEY,
  url VARCHAR(50) IS NOT NULL,
  created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id BIGINT NOT NULL,
);

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  card_id BIGINT NOT NULL, 
  user_id BIGINT NOT NULL,
  is_deleted BIT NOT NULL DEFAULT 0,
  is_black_list BIT NOT NULL DEFAULT 0,
  created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

DROP TABLE IF EXISTS gaming_machines;
CREATE TABLE gaming_machines (
  id SERIAL PRIMARY KEY,
  machine_number INT NOT NULL,
  serial_number BIGING NOT NULL 
  manufacturer_id BIGINT NOT NULL,
  is_blocked BIT NOT NULL DEFAULT 0,
  is_black_list BIT NOT NULL DEFAULT 0,
  created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL, 
  description VARCHAR(255) NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(12) NOT NULL,
);

DROP TABLE IF EXISTS gaming_gays_info;
CREATE TABLE gaming_gays_info (
  id SERIAL PRIMARY KEY,
  start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  end_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

DROP TABLE IF EXISTS game_lot_bonuses;
CREATE TABLE game_lot_bonuses (
  id SERIAL PRIMARY KEY,
  gaming_day_id BIGINT NOT NULL,
  machine_id BIGINT NOT NULL,
  card_id BIGINT NOT NULL,
  operation_id BIGINT NOT NULL,

  description VARCHAR(255) NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(12) NOT NULL,
);

DROP TABLE IF EXISTS operations;
CREATE TABLE operations_type (
  id SERIAL PRIMARY KEY,
  type_id BIGINT NOT NULL,
);


DROP TABLE IF EXISTS operations_types;
CREATE TABLE operations_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
);