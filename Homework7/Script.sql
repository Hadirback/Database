/* Практическое задание по теме “Транзакции, переменные, представления” */

/*
	1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
*/
INSERT INTO sample.users 
SELECT * FROM shop.users u1 WHERE u1.id = 1

/*
	Создайте представление, которое выводит название name товарной позиции из таблицы 
    products и соответствующее название каталога name из таблицы catalogs.
*/
CREATE VIEW prod_view (product_name, catalog_name) 
AS 
SELECT 
	p.name AS product_name
	, c.name AS catalog_name
FROM shop.products p
LEFT JOIN shop.catalogs c
	ON p.catalog_id = c.id;
    
SELECT * FROM prod_view;


/*
	3.Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые
    календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
    Составьте запрос, который выводит полный список дат за август, выставляя в соседнем
    поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

DROP PROCEDURE IF EXISTS insert_date;
DROP TEMPORARY TABLE IF EXISTS calendar_table;

DELIMITER // 
CREATE PROCEDURE `insert_date`()
BEGIN   
	DECLARE datefrom, dateto DATETIME;
    CREATE TEMPORARY TABLE IF NOT EXISTS calendar_table 
	(
		date_column DATETIME NOT NULL
	);
	SET datefrom = '2018-08-01';
	SET dateto = '2018-09-01';
    
    WHILE datefrom < dateto DO
		INSERT INTO calendar_table VALUES (datefrom);
        SET datefrom = DATE_ADD(datefrom, INTERVAL 1 DAY);
	END WHILE;
END //

CALL insert_date();
SELECT 
	date_column 
    , CASE 
		WHEN date_column IN (SELECT created_at FROM users)
			THEN 1
		ELSE 0
	END AS flag
FROM calendar_table;


/*
	4. Пусть имеется любая таблица с календарным полем created_at. 
    Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя 
    только 5 самых свежих записей.
*/

SELECT @min_date := MIN(tbl.date_column)
FROM
(
	SELECT date_column 
	FROM calendar_table 
	ORDER BY date_column DESC 
	LIMIT 5
) tbl;

DELETE FROM calendar_table 
WHERE date_column < @min_date
LIMIT 100;

SELECT * FROM calendar_table;

/*Практическое задание по теме “Хранимые процедуры и функции, триггеры"*/

/*
	1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
	в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
	возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
	фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

DROP PROCEDURE IF EXISTS hello;

DELIMITER //
CREATE PROCEDURE `hello`()
BEGIN
	IF (CURTIME() BETWEEN '06:00' AND '11:59:59') THEN
		SELECT 'Доброе утро';
	ELSEIF (CURTIME() BETWEEN '12:00' AND '17:59:59') THEN
		SELECT 'Добрый день';
	ELSEIF (CURTIME() BETWEEN '18:00' AND '23:59:59') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //

CALL hello();

/*
	2. В таблице products есть два текстовых поля: name с названием товара и description
	с его описанием. Допустимо присутствие обоих полей или одно из них. 
	Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
	Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
	При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
DROP TRIGGER IF EXISTS check_fields_products_update;
DELIMITER //
CREATE TRIGGER check_fields_products_update
BEFORE UPDATE ON shop.products
FOR EACH ROW
BEGIN
	IF COALESCE(NEW.name, NEW.description) IS NULL THEN
		SIGNAL SQLSTATE '10013' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END; //

DROP TRIGGER IF EXISTS check_fields_products_insert;
DELIMITER //
CREATE TRIGGER check_fields_products_insert 
BEFORE INSERT ON shop.products
FOR EACH ROW
BEGIN
	IF COALESCE(NEW.name, NEW.description) IS NULL THEN
		SIGNAL SQLSTATE '10012' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END; //

INSERT INTO shop.products (name, description, price, catalog_id) VALUE ('NXX', NULL, 10, 1);
UPDATE shop.products SET name := NULL, description := NULL, price = 20, catalog_id = 1 WHERE id = 1;

/*
	3. Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
	 Числами Фибоначчи называется последовательность в которой число равно сумме двух
	 предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

DROP PROCEDURE get_fibonachi;

DELIMITER //
CREATE PROCEDURE get_fibonachi(IN value INT, OUT result INT)   
BEGIN
	IF value = 0 THEN
		SET result := 0;
	ELSEIF value > 0 THEN
		SET @first_num := 0, @second_num := 1;
		SET @index := value;

		WHILE @index > 0 DO
			SET @temp_value = @first_num;
			SET @first_num := @first_num + @second_num;
            SET @second_num := @temp_value;
            SET @index := @index - 1;
		END WHILE;
        SET result := @first_num;
	END IF;
END; //

SET @res := 0;
CALL get_fibonachi(1, @res);
SELECT @res;
