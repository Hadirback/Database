-- Первое задание в файлах 001_full_script_add_data_into_tables/002_only_add_data_into_tables

/*
  2. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
*/

SELECT DISTINCT firstname 
FROM vk.users 
ORDER BY firstname;

/*
  3. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
  (поле is_active = false). Предварительно добавить такое поле в таблицу 
  profiles со значением по умолчанию = true (или 1)
*/

ALTER TABLE vk.profiles 
ADD is_active BIT DEFAULT 1 NOT NULL;

UPDATE vk.profiles 
SET is_active = 0 
WHERE DATE_ADD(birthday, INTERVAL 18 YEAR) >= DATE_ADD(NOW(), INTERVAL -1 DAY);

/*
  4. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
*/

DELETE FROM vk.messages WHERE created_at > NOW();

/*
  5. Написать название темы курсового проекта (в комментарии) . 
*/

-- Тема курсового рпоекта "Модель данных системы мини-казино."