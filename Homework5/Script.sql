-- Урок 6. Вебинар. Операторы, фильтрация, сортировка и ограничение. Агрегация данных

/* 
  1. Пусть задан некоторый пользователь. Из всех друзей этого пользователя
  найдите человека, который больше всех общался с нашим пользователем.
*/

SET @user_id = 2; 

SELECT 
  from_user_id
FROM messages
WHERE to_user_id = @user_id
  AND from_user_id IN 
  (
    SELECT 
      target_user_id AS from_user_id
    FROM friend_requests
    WHERE initiator_user_id = @user_id
      AND status = 'approved'
    
    UNION
    
    SELECT 
      initiator_user_id AS from_user_id
    FROM friend_requests
    WHERE target_user_id = @user_id
      AND status = 'approved'
  )
GROUP BY from_user_id
ORDER BY COUNT(*) DESC
LIMIT 1;


/*
  2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
*/

SELECT
  COUNT(*) AS count_likes
FROM likes l
WHERE l.media_id IN 
(
  SELECT 
    m.id AS media_id
  FROM media m
  WHERE m.user_id IN 
  (
    SELECT 
      p.user_id 
    FROM profiles p
    WHERE 
    (
      (YEAR(NOW()) - YEAR(p.birthday)) - 
      (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(p.birthday, '%m%d'))
    ) < 10
  )
);


/*
  3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/

SELECT
  CASE 
    WHEN gender = 1 AND tab.count_likes = MAX(tab.count_likes)
      THEN 'МУЖЧИНЫ'
    ELSE 'ЖЕНЩИНЫ'
  END AS gender
FROM
(
  SELECT 
    COUNT(*) AS count_likes
    , 1 AS gender
  FROM likes l
  WHERE l.media_id IN 
  (
    SELECT 
      m.id AS media_id
    FROM media m
    WHERE m.user_id IN 
    (
      SELECT p.user_id 
      FROM profiles p
      WHERE p.gender = 'm'
    )
  )
  
  UNION
  
  SELECT 
    COUNT(*) AS count_likes
    , 0 AS gender
  FROM likes l
  WHERE l.media_id IN 
  (
    SELECT 
      m.id AS media_id
    FROM media m
    WHERE m.user_id IN 
    (
      SELECT p.user_id 
      FROM profiles p
      WHERE p.gender = 'w'
    )
  )
) AS tab;

