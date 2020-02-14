/*
 * 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.
 * */

UPDATE users SET 
	created_at = NOW(),
	updated_at = NOW();

/*
 * 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом 
 * VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
 * */

UPDATE users SET 
  created_at = STR_TO_DATE(created_at, "%d.%m.%Y %h:%i"), 
  updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %h:%i");
 
ALTER TABLE users 
  MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

/*
 * 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы.
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.
 * */
 
SELECT * 
FROM storehouses_product 
ORDER BY IF(value = 0, 1, 0), value;

/*
 * 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий ('may', 'august')
 * */

SELECT *
FROM users
WHERE DATE_FORMAT(birthday_at, '%M') = 'may' 
	OR DATE_FORMAT(birthday_at, '%M') = 'august';
	
/* 5. Из таблицы catalogs извлекаются записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * Отсортируйте записи в порядке, заданном в списке IN.
 * */
	
SELECT * 
FROM (SELECT * 
	FROM catalogs 
	WHERE id IN (5, 1, 2)) AS tab
ORDER BY IF(tab.id = 5, 0, 1), tab.id;


-----------------------------------------------
-- Практическое задание теме “Агрегация данных”
-----------------------------------------------

 /*
  * 1. Подсчитайте средний возраст пользователей в таблице users
  * */

SELECT 
	AVG(
	    (YEAR(NOW()) - YEAR(birthday_at)) -                             
	    (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(birthday_at, '%m%d'))
	) AS avg_age
FROM users; 

/*
 * 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 * */

SELECT 
	COUNT(*) AS count_of_day
	, tab.day_of_week 
FROM 
(
	SELECT 
		DATE_FORMAT(CONCAT(YEAR(NOW()), DATE_FORMAT(birthday_at, '-%m-%d')), '%W') AS day_of_week
	FROM users
) tab
GROUP BY tab.day_of_week;

/*
 * 3. Подсчитайте произведение чисел в столбце таблицы
 * */

DROP TEMPORARY TABLE IF EXISTS tmp_tab;
CREATE TEMPORARY TABLE tmp_tab (
	value INT NOT NULL
);

INSERT INTO tmp_tab VALUES (1), (2), (3), (4), (5);

SELECT EXP(SUM(LOG(value))) FROM tmp_tab;















