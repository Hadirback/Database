/*
 * 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. 
 * ��������� �� �������� ����� � ��������.
 * */

UPDATE users SET 
	created_at = NOW(),
	updated_at = NOW();

/*
 * 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� 
 * VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". 
 * ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
 * */

UPDATE users SET 
  created_at = STR_TO_DATE(created_at, "%d.%m.%Y %h:%i"), 
  updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %h:%i");
 
ALTER TABLE users 
  MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

/*
 * 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
 * 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
 * ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
 * ������, ������� ������ ������ ���������� � �����, ����� ���� �������.
 * */
 
SELECT * 
FROM storehouses_product 
ORDER BY IF(value = 0, 1, 0), value;

/*
 * 4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
 * ������ ������ � ���� ������ ���������� �������� ('may', 'august')
 * */

SELECT *
FROM users
WHERE DATE_FORMAT(birthday_at, '%M') = 'may' 
	OR DATE_FORMAT(birthday_at, '%M') = 'august';
	
/* 5. �� ������� catalogs ����������� ������ ��� ������ �������. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * ������������ ������ � �������, �������� � ������ IN.
 * */
	
SELECT * 
FROM (SELECT * 
	FROM catalogs 
	WHERE id IN (5, 1, 2)) AS tab
ORDER BY IF(tab.id = 5, 0, 1), tab.id;


-----------------------------------------------
-- ������������ ������� ���� ���������� �������
-----------------------------------------------

 /*
  * 1. ����������� ������� ������� ������������� � ������� users
  * */

SELECT 
	AVG(
	    (YEAR(NOW()) - YEAR(birthday_at)) -                             
	    (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(birthday_at, '%m%d'))
	) AS avg_age
FROM users; 

/*
 * 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
 * ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
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
 * 3. ����������� ������������ ����� � ������� �������
 * */

DROP TEMPORARY TABLE IF EXISTS tmp_tab;
CREATE TEMPORARY TABLE tmp_tab (
	value INT NOT NULL
);

INSERT INTO tmp_tab VALUES (1), (2), (3), (4), (5);

SELECT EXP(SUM(LOG(value))) FROM tmp_tab;















