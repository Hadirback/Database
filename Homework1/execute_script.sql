-- �������� ���� ������ example
CREATE DATABASE IF NOT EXISTS example;

-- ����� example
USE example;

-- �������� ������� users
CREATE TABLE IF NOT EXISTS users 
(
	id 		INT PRIMARY KEY AUTO_INCREMENT,
	nam�e 	VARCHAR(200) NOT NULL
);

-- �������� ���� ������ sample
CREATE DATABASE IF NOT EXISTS sample;
