-- Создание базы данных example
CREATE DATABASE IF NOT EXISTS example;

-- Выбор example
USE example;

-- Создание таблицы users
CREATE TABLE IF NOT EXISTS users 
(
	id 		INT PRIMARY KEY AUTO_INCREMENT,
	namыe 	VARCHAR(200) NOT NULL
);

-- Создание базы данных sample
CREATE DATABASE IF NOT EXISTS sample;
