/*
	1. Составьте список пользователей users, которые осуществили 
    хотя бы один заказ orders в интернет магазине.
*/

SELECT 
	u.id
	, u.name
FROM users u
JOIN orders o
	ON o.user_id = u.id;
    
/*
	2. Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT 
	p.name AS product_name
    , c.name AS catalog_name
FROM products p
LEFT JOIN catalogs c
	ON c.id = p.catalog_id;
    
/*
	3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов 
    cities (label, name). Поля from, to и label содержат английские названия городов,
    поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

SELECT 
	f.id
	, c1.name AS from
	, c2.name AS to
FROM flights f
LEFT JOIN cities c1
	ON c1.label = f.from
LEFT JOIN cities c2
	ON c2.label = f.to
ORDER BY f.id;
    



