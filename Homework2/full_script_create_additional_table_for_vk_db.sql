/* Задача 3 урока
Написать крипт, добавляющий в БД vk, которую создали на занятии, 
3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
*/

-- Это полный скрипт включающий в себя предыдующий урок. Он полностью рабочий

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE NOT NULL,
    phone VARCHAR(12) NOT NULL,
    INDEX users_phone_idx(phone), 
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums (
	id SERIAL PRIMARY KEY,
	`name` VARCHAR(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body TEXT,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX media_user_id(user_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL PRIMARY KEY,
	album_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (album_id) REFERENCES photo_albums(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (media_id) REFERENCES media(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1) NOT NULL,
    birthday DATE,
    photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
	FOREIGN KEY (photo_id) REFERENCES photos(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    
    INDEX messages_from_user_id (from_user_id),
    INDEX messages_to_user_id (to_user_id),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
        FOREIGN KEY (to_user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    requested_at DATETIME DEFAULT NOW(),
    confirmed_at DATETIME,
    
    PRIMARY KEY(initiator_user_id, target_user_id),
    INDEX friend_requests_initiator_user_id(initiator_user_id),
    INDEX friend_requests_target_user_id(target_user_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (target_user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
	id SERIAL PRIMARY KEY,
	`name` VARCHAR(150) NOT NULL,

	INDEX communities_name_idx(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities (
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (community_id) REFERENCES communities(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

	FOREIGN KEY (user_id) REFERENCES users(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (media_id) REFERENCES media(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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






