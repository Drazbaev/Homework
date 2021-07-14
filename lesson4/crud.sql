mysql> use vk;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> UPDATE profiles SET city_id = FLOOR(1 + RAND() * 100);
Query OK, 99 rows affected (0,00 sec)
Rows matched: 100  Changed: 99  Warnings: 0

mysql> CREATE TEMPORARY TABLE countries_temp (name VARCHAR(120));
Query OK, 0 rows affected (0,00 sec)

mysql> INSERT INTO countries_temp VALUES 
    ->   ('Bolgaria'),
    ->   ('Great Britain'),
    ->   ('USA'),
    ->   ('Chech Republic');
Query OK, 4 rows affected (0,00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> 
mysql> UPDATE countries 
    ->   SET name = (SELECT name FROM countries_temp ORDER BY RAND() LIMIT 1);
Query OK, 100 rows affected (0,02 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> UPDATE messages SET
    ->   from_user_id = FLOOR(1 + RAND() * 100),
    ->   to_user_id = FLOOR(1 + RAND() * 100);
Query OK, 100 rows affected (0,01 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql>   
mysql> UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
Query OK, 99 rows affected (0,01 sec)
Rows matched: 100  Changed: 99  Warnings: 0

mysql> 
mysql> CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
Query OK, 0 rows affected (0,00 sec)

mysql> 
mysql> INSERT INTO extensions VALUES ('jpeg'), ('mp4'), ('mp3'), ('avi'), ('png');
Query OK, 5 rows affected (0,00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> 
mysql> UPDATE media SET filename = CONCAT(
    ->   'http://dropbox.net/vk/',
    ->   filename,
    ->   '.',
    ->   (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
    -> );
Query OK, 100 rows affected (0,01 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> 
mysql> UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;
Query OK, 38 rows affected (0,01 sec)
Rows matched: 38  Changed: 38  Warnings: 0

mysql> 
mysql> UPDATE media SET metadata = CONCAT('{"owner":"', 
    ->   (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
    ->   '"}');  
Query OK, 100 rows affected (0,01 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> ALTER TABLE media MODIFY COLUMN metadata JSON;
Query OK, 100 rows affected (0,06 sec)
Records: 100  Duplicates: 0  Warnings: 0

mysql> DELETE FROM media_types;
Query OK, 10 rows affected (0,00 sec)

mysql> 
mysql> INSERT INTO media_types (name) VALUES
    ->   ('photo'),
    ->   ('video'),
    ->   ('audio')
    -> ;
Query OK, 3 rows affected (0,00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> TRUNCATE media_types;
Query OK, 0 rows affected (0,04 sec)

mysql> 
mysql> UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
Query OK, 99 rows affected (0,01 sec)
Rows matched: 100  Changed: 99  Warnings: 0

mysql> 
mysql> UPDATE friendship SET 
    ->   user_id = FLOOR(1 + RAND() * 100),
    ->   friend_id = FLOOR(1 + RAND() * 100);
Query OK, 100 rows affected (0,02 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> 
mysql> UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;
Query OK, 1 row affected (0,00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>  
mysql> TRUNCATE friendship_statuses;
Query OK, 0 rows affected (0,03 sec)

mysql> 
mysql> INSERT INTO friendship_statuses (name) VALUES
    ->   ('Requested'),
    ->   ('Confirmed'),
    ->   ('Rejected');
Query OK, 3 rows affected (0,01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3); 
Query OK, 95 rows affected (0,02 sec)
Rows matched: 100  Changed: 95  Warnings: 0


mysql> TRUNCATE communities_users;
Query OK, 0 rows affected (0,03 sec)

mysql> 
mysql> UPDATE communities_users SET
    ->   user_id = FLOOR(1 + RAND() * 100),
    ->   community_id = FLOOR(1 + RAND() * 30);

