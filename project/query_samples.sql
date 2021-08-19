-- Определить количество заказов по покупателям
SELECT CONCAT(first_name, ' ', last_name) AS user_name,
  COUNT(DISTINCT orders.id) 
  FROM orders
    LEFT JOIN customers 
      ON orders.customer_id = customers.id
     GROUP BY CONCAT(first_name, ' ', last_name);
	 
	 
-- вывести категории товаров по городам
select c.name city,
ca.category_name category_name
from orders o left join goods g on o.good_id=g.id left join categories ca on g.category_id=ca.id left join 
profiles p on o.customer_id=p.user_id left join cities c on p.city_id=c.id group by c.name, ca.category_name order by city;