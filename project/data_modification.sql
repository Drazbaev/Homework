-- работа с данными

UPDATE
	profiles
SET
	city_id = FLOOR(1 + RAND() * 100);

UPDATE
	orders
SET
	customer_id = FLOOR(1 + RAND() * 100);

UPDATE
	orders
SET
	good_id = FLOOR(1 + RAND() * 100);

UPDATE
	cities
SET
	country_id = FLOOR(1 + RAND() * 20);

UPDATE
	prices
SET
	category_id = FLOOR(1 + RAND() * 20);

UPDATE
	prices
SET
	good_id = FLOOR(1 + RAND() * 100);

insert
	into
		genders (id, name)
	values (1, 	'male'),
	(2,	'female');

commit;



update
	prices
set
	discount_id = FLOOR(1 + (RAND() * 3));

commit;

insert
	into
		promo (id, category_id, discount_amt)
	values 
	(1,	4,	0.5),
	(2,	10,	0.1),
	(3,	7,	0.2);

commit;


