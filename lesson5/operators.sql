

 ######################### Sort,Filterin and Restrictions operators ##################################

Task 1

Database changed
mysql> use vk;
Database changed
mysql> update users set created_at=now();
Query OK, 100 rows affected (0,02 sec)
Rows matched: 100  Changed: 100  Warnings: 0

mysql> update users set created_at=now(),updated_at=now();
Query OK, 100 rows affected (0,02 sec)
Rows matched: 100  Changed: 100  Warnings: 0



Task2

mysql> create table users_varchar as select * from users where 1=0;
Query OK, 0 rows affected (0,02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table users_varchar modify created_at varchar(16);
Query OK, 0 rows affected (0,07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table users_varchar modify updated_at varchar(16);
Query OK, 0 rows affected (0,06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc users_new;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| id         | int unsigned | NO   |     | 0       |       |
| first_name | varchar(100) | NO   |     | NULL    |       |
| last_name  | varchar(100) | NO   |     | NULL    |       |
| email      | varchar(100) | NO   |     | NULL    |       |
| phone      | varchar(100) | NO   |     | NULL    |       |
| created_at | varchar(16)  | YES  |     | NULL    |       |
| updated_at | varchar(16)  | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
7 rows in set (0,01 sec)

mysql> insert into users_varchar select id, first_name,last_name,email,phone,substr(cast(created_at as char),1,16),substr(cast(updated_at as char),1,16) from users;
Query OK, 100 rows affected (0,01 sec)
Records: 100  Duplicates: 0  Warnings: 0

mysql> select * from users_varchar limit 10;
+----+------------+-------------+-------------------------------+------------------+------------------+------------------+
| id | first_name | last_name   | email                         | phone            | created_at       | updated_at       |
+----+------------+-------------+-------------------------------+------------------+------------------+------------------+
|  1 | Citlalli   | Greenholt   | renner.alphonso@example.net   | 07757343014      | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  2 | Baylee     | Nader       | rhettinger@example.org        | 1-121-399-8173   | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  3 | Kaylah     | Runolfsson  | gus.swift@example.org         | 631-996-6643     | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  4 | Carmine    | Fay         | adelia85@example.org          | 1-991-740-1813   | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  5 | Wilmer     | Morar       | pollich.ellis@example.org     | 1-950-220-2665   | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  6 | Bethel     | Dicki       | hahn.hettie@example.net       | 463.935.4526x053 | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  7 | Ray        | Pfeffer     | dane96@example.com            | 258-667-2907     | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  8 | Abigale    | Tremblay    | lon03@example.net             | 551-966-4092     | 2021-07-15 17:11 | 2021-07-15 17:11 |
|  9 | Hal        | Ledner      | lawrence07@example.net        | 077-434-9663     | 2021-07-15 17:11 | 2021-07-15 17:11 |
| 10 | Shirley    | Oberbrunner | hodkiewicz.rebeca@example.com | 00180204372      | 2021-07-15 17:11 | 2021-07-15 17:11 |
+----+------------+-------------+-------------------------------+------------------+------------------+------------------+
10 rows in set (0,00 sec)

mysql> create table users_datetime as select * from users where 1=0;
Query OK, 0 rows affected (0,03 sec)
Records: 0  Duplicates: 0  Warnings: 0


mysql> insert into users_datetime select id, first_name,last_name,email,phone,str_to_date(created_at,'%Y-%m-%d %H:%MI'),str_to_date(updated_at,'%Y-%m-%d %H:%MI') from users_varchar;
ERROR 1411 (HY000): Incorrect datetime value: '2021-07-15 17:11' for function str_to_date
mysql> insert into users_datetime select id, first_name,last_name,email,phone,str_to_date(created_at,'%Y-%m-%d %H:%i'),str_to_date(updated_at,'%Y-%m-%d %H:%i') from users_varchar;
Query OK, 100 rows affected (0,01 sec)
Records: 100  Duplicates: 0  Warnings: 0

mysql> select * from users_datetime limit 10;
+----+------------+-------------+-------------------------------+------------------+---------------------+---------------------+
| id | first_name | last_name   | email                         | phone            | created_at          | updated_at          |
+----+------------+-------------+-------------------------------+------------------+---------------------+---------------------+
|  1 | Citlalli   | Greenholt   | renner.alphonso@example.net   | 07757343014      | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  2 | Baylee     | Nader       | rhettinger@example.org        | 1-121-399-8173   | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  3 | Kaylah     | Runolfsson  | gus.swift@example.org         | 631-996-6643     | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  4 | Carmine    | Fay         | adelia85@example.org          | 1-991-740-1813   | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  5 | Wilmer     | Morar       | pollich.ellis@example.org     | 1-950-220-2665   | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  6 | Bethel     | Dicki       | hahn.hettie@example.net       | 463.935.4526x053 | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  7 | Ray        | Pfeffer     | dane96@example.com            | 258-667-2907     | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  8 | Abigale    | Tremblay    | lon03@example.net             | 551-966-4092     | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
|  9 | Hal        | Ledner      | lawrence07@example.net        | 077-434-9663     | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
| 10 | Shirley    | Oberbrunner | hodkiewicz.rebeca@example.com | 00180204372      | 2021-07-15 17:11:00 | 2021-07-15 17:11:00 |
+----+------------+-------------+-------------------------------+------------------+---------------------+---------------------+
10 rows in set (0,00 sec)



Task 3


mysql> create table storehouse_products (id int, value int);
Query OK, 0 rows affected (0,03 sec)


mysql> insert into storehouse_products values (1,200), (2,300), (3,400),(4, NULL);
Query OK, 4 rows affected (0,01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from storehouse_products order by value asc;
+------+-------+
| id   | value |
+------+-------+
|    4 |  NULL |
|    1 |   200 |
|    2 |   300 |
|    3 |   400 |
+------+-------+
4 rows in set (0,00 sec)


mysql> select * from storehouse_products order by case when value is null then 1 else 0 end, value asc;
+------+-------+
| id   | value |
+------+-------+
|    1 |   200 |
|    2 |   300 |
|    3 |   400 |
|    4 |  NULL |
+------+-------+
4 rows in set (0,00 sec)



 ######################### AGGREGATION ##################################

Task 1

mysql> select avg(datediff ( curdate(),p.birthday)/365) from profiles p ;
+-------------------------------------------+
| avg(datediff ( curdate(),p.birthday)/365) |
+-------------------------------------------+
|                               24.90397260 |
+-------------------------------------------+
1 row in set (0,00 sec)


Task2 

mysql> select dayofweek(p.birthday) dow, count(dayofweek(p.birthday)) cnt_dow from profiles p  group by dow;
+------+---------+
| dow  | cnt_dow |
+------+---------+
|    5 |      18 |
|    2 |      15 |
|    1 |      17 |
|    7 |      18 |
|    4 |      16 |
|    6 |       8 |
|    3 |       8 |
+------+---------+
7 rows in set (0,00 sec)

Task 3

mysql> select dayofweek(concat('2021',substr(cast(p.birthday as char),5,16))) dow,count(dayofweek(concat('2021',substr(cast(p.birthday as char),5,16)))) cnt_dow  from profiles p group by dow;
+------+---------+
| dow  | cnt_dow |
+------+---------+
|    5 |      10 |
|    3 |      15 |
|    1 |      16 |
|    7 |      12 |
|    6 |      22 |
|    4 |      14 |
|    2 |      10 |
| NULL |       0 |
+------+---------+


