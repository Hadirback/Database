/* Задача 3 урока
Написать крипт, добавляющий в БД vk, которую создали на занятии, 
3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
*/

USE vk;

-- Таблица содержащая посты
-- id community которая разместила пост
-- для прикрепления дополнительных медиа данных служит таблица post_media
-- created_at, updated_at - даты создания и обновления
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
	id SERIAL PRIMARY KEY,
    community_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX posts_idx_community_id(community_id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Вспомогательная таблица, содержащая id post и соответствующие ему медиа данные
DROP TABLE IF EXISTS post_media;
CREATE TABLE post_media (
	post_id BIGINT UNSIGNED NOT NULL, 
    media_id BIGINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (post_id, media_id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (media_id) REFERENCES media(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Таблица комментариев к посту
-- id user который его оставил
-- post id к которому отностится комментарий
-- body - текст комментария
-- created_at, updated_at - даты создания и обновления
DROP TABLE IF EXISTS сomments;
CREATE TABLE сomments (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX сomments_idx_user_id(user_id),
    INDEX сomments_idx_post_id(post_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (post_id) REFERENCES posts(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);


