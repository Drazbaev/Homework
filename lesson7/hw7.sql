-- task 1

SELECT users.id, users.name, users.birthday_at
  FROM users
   JOIN orders
     ON users.id = orders.user_id;

-- task 2

SELECT
  products.id,
  products.name,
  products.price,
  catalogs.name catalog
FROM products
  LEFT JOIN catalogs
    ON products.catalog_id = catalogs.id;