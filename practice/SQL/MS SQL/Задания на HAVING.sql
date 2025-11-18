/*Вывести номер заказа, сумму скидки по тем заказам, в которых общая сумма  скидки составила не менее 500 у.е. 
Группировать по сумме скидке по убыванию.*/
SELECT order_id, SUM(list_price*discount) AS Сумма_скидки
FROM sales.order_items
GROUP BY order_id
HAVING SUM(list_price*discount)>=500
ORDER BY Сумма_скидки

/*Вывести номер заказа и число товаров в заказе, только для заказов, в которых не менее 5 товаров. 
Группировать по возрастанию числа товаров в заказе.*/
SELECT order_id, SUM(quantity) Количество_товаров
FROM sales.order_items
GROUP BY order_id
HAVING SUM(quantity) > 4
ORDER BY Количество_товаров

/*Вывести id бренда и среднюю цену на товары по данному бренду. 
Упорядочить по убыванию средней цены.*/
 SELECT brand_id, AVG(list_price) Средняя_цена
 FROM production.products
 GROUP BY brand_id
 ORDER BY Средняя_цена DESC
