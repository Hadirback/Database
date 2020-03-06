/*Практическое задание по теме “Оптимизация запросов”*/

/*
	1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
	catalogs и products в таблицу logs помещается время и дата создания записи, название 
	таблицы, идентификатор первичного ключа и содержимое поля name.
*/
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
	`id` SERIAL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `table_name` VARCHAR(100) NOT NULL,
    `object_id` INT NOT NULL,
    `object_name` VARCHAR(255)
) ENGINE=Archive;

DELIMITER //
CREATE TRIGGER log_users_table AFTER INSERT ON shop.users
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, object_id, object_name) VALUES ('users', NEW.id, NEW.name);
END; //

DELIMITER //
CREATE TRIGGER log_catalogs_table AFTER INSERT ON shop.catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, object_id, object_name) VALUES ('catalogs', NEW.id, NEW.name);
END; //

DELIMITER //
CREATE TRIGGER log_products_table AFTER INSERT ON shop.products
FOR EACH ROW
BEGIN
	INSERT INTO logs (table_name, object_id, object_name) VALUES ('products', NEW.id, NEW.name);
END; //

/*
	2. Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

DROP PROCEDURE IF EXISTS add_millon_rows_into_users_table;
DELIMITER //
CREATE PROCEDURE add_millon_rows_into_users_table() 
BEGIN
	SET @count = 1;
    WHILE @count <= 10 DO
		INSERT INTO users (name, birthday_at) VALUE ( CONCAT('test_user', @count), FROM_UNIXTIME(RAND() * 2147483647));
        SET @count := @count + 1;
    END WHILE;
END; //

CALL add_millon_rows_into_users_table;
SELECT * FROM users


/*Практическое задание по теме “NoSQL”*/

/*
	1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
*/

-- Хеш-таблицы
-- HSET ip_addresses 'адрес' значение

/*
	2. При помощи базы данных Redis решите задачу поиска имени пользователя 
    по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
*/

/*
	Если имя пользователя ключ, а емайл его значение то
    SET user email_user
    GET user
    Если емайл ключ, то имя пользователя его значение 
    SET email_user user
    GET email_user
*/

/*
	3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/

/*
catalogs
{ "_id" : ObjectId("1", "name" : "Процессоры")}
{ "_id" : ObjectId("2", "name" : "Мат. платы")}
{ "_id" : ObjectId("3", "name" : "Видеокарты")}
{ "_id" : ObjectId("4", "name" : "Опер. память")}
{ "_id" : ObjectId("5", "name" : "Системный Блок")}

products
{ "_id" : ObjectId("1", "name" : "Intel Core i5-7400", description : "Мощный процессор", price : 14224, catalog_id : 1, created_at : "2020-02-22 14:33:02", updated_at : "2020-02-22 14:33:02")}
{ "_id" : ObjectId("2", "name" : "NVidia GTX 1660 Ti", description : "Достойная видеокарта", price : 10000, catalog_id : 3, created_at : "2020-02-22 14:33:02", updated_at : "2020-02-22 14:33:02")}
*/
