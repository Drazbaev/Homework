--task 1

CREATE TABLE likes (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на пользователя, которому поставлен like',
  target_id int unsigned NOT NULL COMMENT 'Ссылка на тип контента которому поставлен like',
  target_type varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'описание типа контента которому поставлен like',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id))   COMMENT="Лайки";
  


CREATE TABLE posts (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на автора поста',
  body TEXT NOT NULL COMMENT "Текст поста",
  is_published tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  created_at  datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
)  COMMENT='Посты';
 
 --task 2
 

CREATE TABLE likes (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на пользователя, которому поставлен like',
  target_id int unsigned NOT NULL COMMENT 'Ссылка на тип контента которому поставлен like',
  target_type varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'описание типа контента которому поставлен like',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id))   COMMENT="Лайки";
  


CREATE TABLE posts (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на автора поста',
  body TEXT NOT NULL COMMENT "Текст поста",
  is_published tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  created_at  datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
)  COMMENT='Посты';
 



CREATE TABLE likes (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на пользователя, которому поставлен like',
  target_id int unsigned NOT NULL COMMENT 'Ссылка на тип контента которому поставлен like',
  target_type varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'описание типа контента которому поставлен like',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id))   COMMENT="Лайки";
  


CREATE TABLE posts (
  id int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int unsigned NOT NULL COMMENT 'Ссылка на автора поста',
  body TEXT NOT NULL COMMENT "Текст поста",
  is_published tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  created_at  datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
)  COMMENT='Посты';
 

ALTER TABLE cities
  ADD CONSTRAINT cities_to_country_id_fk 
    FOREIGN KEY (country_id) REFERENCES countries(id);


ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_to_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(communitiesid);

ALTER TABLE likes
  ADD CONSTRAINT likes_to_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
ALTER TABLE profiles
  ADD CONSTRAINT profiles_to_city_id_fk 
    FOREIGN KEY (city_id) REFERENCES cities(id);
   
ALTER TABLE messages
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_to_users_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);     

ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_to_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_to_users_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friendship_status_id_to_friendship_id_fk 
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id);

    
ALTER TABLE likes
  ADD CONSTRAINT likes_target_id_to_media_types_id_fk 
    FOREIGN KEY (target_id) REFERENCES media_types(id),
  ADD CONSTRAINT likes_target_type_to_media_types_name_fk 
    FOREIGN KEY (target_type) REFERENCES media_types(name)
  ADD CONSTRAINT users_user_id_to_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
ALTER TABLE media
  ADD CONSTRAINT media_user_id_to_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
ALTER TABLE posts
  ADD CONSTRAINT posts_to_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
   ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_to_users_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
 
 --task 3
      
     SELECT 
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS amount
    FROM likes
    GROUP BY gender
    ORDER BY amount DESC
    LIMIT 1;

  
 --task 4
   
   
   SELECT 
  CONCAT(first_name, ' ', last_name) user,
  (SELECT COUNT(*) FROM messages m WHERE m.from_user_id = users.id)  total_messages,
  (SELECT COUNT(*) FROM posts p WHERE p.user_id = users.id)  posts,  
	(SELECT COUNT(*) FROM media m WHERE m.user_id = users.id)  media, 
	(SELECT COUNT(*) FROM likes l WHERE l.user_id = users.id)  likes
	  FROM users ;
   