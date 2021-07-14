mysql> create database example;
Query OK, 1 row affected (0,00 sec)

mysql> create table users (id integer, name varchar(100));
Query OK, 0 rows affected (0,03 sec)

dmitry@dmitry-VirtualBox:~$ sudo mysqldump example > example.sql
dmitry@dmitry-VirtualBox:~$ ls
Desktop    Downloads    flush         help_keyword_report.sql  july10.ovpn  Pictures  Templates  Videos
Documents  example.sql  Hadoop01.pem  hosts.txt                Music        Public    test.txt   vk_dump_generated.sql
dmitry@dmitry-VirtualBox:~$ vi example.sql
mysql> create database sample;
Query OK, 1 row affected (0,01 sec)
dmitry@dmitry-VirtualBox:~$ sudo mysql sample < example.sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sample             |
| sys                |
+--------------------+
6 rows in set (0,01 sec)

mysql> use sample;
mysql> show tables
    -> ;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0,01 sec)
