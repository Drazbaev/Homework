create database ozon;
use ozon;
CREATE TABLE customers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя покупателя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия покупателя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Покупатели";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на ID покупателя", 
  gender ENUM ('male','female') NOT NULL COMMENT "пол",  
  birthday DATE COMMENT "Дата рождения",
  city_id INT UNSIGNED COMMENT "Ссылка на город проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица городов
CREATE TABLE cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL COMMENT "Наименование Города",
  country_id INT UNSIGNED COMMENT "Ссылка на страну",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
);

-- Таблица стран
CREATE TABLE countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY  COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL COMMENT "Название страны"
);


-- Таблица цен товаров
CREATE TABLE prices (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  good_id INT NOT NULL COMMENT "ссылка на идентификатор товара",
  category_id INT NOT NULL COMMENT "ссылка на категорию таваров",
  price DECIMAL(38,0) NOT NULL COMMENT "цена товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Цены";

-- Таблица товаров
CREATE TABLE goods (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(150) NOT NULL COMMENT "Наименование товара",
  category_id INT NOT NULL COMMENT "ссылка на категорию таваров",
  description TEXT NOT NULL COMMENT "Описание товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Товары";


-- Таблица заказов
CREATE TABLE orders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  customer_id INT NOT NULL COMMENT "идентификатор покупателя",
  good_id INT NOT NULL COMMENT "идентификатор покупателя",
  status ENUM ('new','in processing','paied', 'delivered') NOT NULL COMMENT "статус заказа",  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "заказы";

-- Таблица категорий товаров
CREATE TABLE categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  category_name VARCHAR (128) NOT NULL COMMENT "наименование категории товаров",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Категория товаров";

ALTER TABLE
	prices ADD CONSTRAINT prices_to_promo_id_fk FOREIGN KEY (promo_id) REFERENCES promo(id);
ALTER TABLE
	promo ADD CONSTRAINT promo_to_categories_id_fk FOREIGN KEY (category_id) REFERENCES categories(id);
ALTER TABLE
	profiles ADD CONSTRAINT profiles_to_genders_id_fk FOREIGN KEY (gender_id) REFERENCES genders(id);
	
ALTER TABLE
	profiles ADD CONSTRAINT profiles_to_cities_id_fk FOREIGN KEY (city_id) REFERENCES cities(id);

ALTER TABLE
	orders ADD CONSTRAINT orders_to_goods_id_fk FOREIGN KEY (good_id) REFERENCES goods(id);

ALTER TABLE
	cities ADD CONSTRAINT cities_to_country_id_fk FOREIGN KEY (country_id) REFERENCES countries(id);

ALTER TABLE
	goods ADD CONSTRAINT goods_to_category_id_fk FOREIGN KEY (category_id) REFERENCES categories(id);

ALTER TABLE
	prices ADD CONSTRAINT prices_to_category_id_fk FOREIGN KEY (category_id) REFERENCES categories(id);

CREATE
	TABLE
		genders (id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150) NOT NULL);

CREATE
	TABLE
		promo (id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		category_id int NOT NULL,
		discount_amt decimal (38,
		0));

----Создание VIEW


create view customers_details  as 
select cu.id,
cu.first_name,
cu.last_name,
cu.email,
cu.phone,
p.birthday,
c.name as city,
g.name as gender
from customers cu join profiles p on cu.id=p.user_id join cities c on p.city_id=c.id join genders g on p.gender_id=g.id;



create or replace view promo_goods  as 
select g.id,
g.name product_name,
c.category_name category,
p.price-(p.price*pr.discount_amt) promo_price
from goods g join prices p on g.id=p.good_id join categories c on p.category_id=c.id join promo pr on p.category_id=pr.category_id ;

--Создание процедуры

delimiter //

CREATE PROCEDURE category_with_max_price (OUT category_name varchar(150))
       BEGIN
         select 
c.category_name category_name into category_name
from prices p join categories c on p.category_id=c.id  group by c.category_name having max(p.price) limit 1;
       END//
