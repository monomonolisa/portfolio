/*
С использованием обобщенных табличных выражений выведите
среднее и максимальное число заказов на одного клиента за весь период
*/
WITH CustomersCounts AS (
	SELECT customer_id, COUNT(*) order_count
	FROM sales.orders
	GROUP BY customer_id
)
SELECT AVG(order_count*1.0) ñðåäíåå_÷èñëî, MAX(order_count) ìàêñèìàëüíîå_÷èñëî
FROM CustomersCounts

/*
С использованием обобщенных табличных выражений выведите
суммарные продажи с учетом скидок за 2018 год, с указанием brand_id и brand_name
*/     
WITH CustomersCounts AS (
    SELECT oi.order_id, oi.product_id, oi.quantity, oi.list_price, oi.discount
    FROM sales.order_items oi
    JOIN sales.orders o ON oi.order_id = o.order_id
    WHERE YEAR(o.order_date) = 2018),
brand_sales AS (
    SELECT b.brand_id, b.brand_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) total_sales_with_discount
    FROM CustomersCounts oi
    JOIN production.products p ON oi.product_id = p.product_id
    JOIN production.brands b ON p.brand_id = b.brand_id
    GROUP BY b.brand_id, b.brand_name
)
SELECT brand_id, brand_name, ROUND(total_sales_with_discount, 2) total_sales_with_discount
FROM brand_sales
ORDER BY total_sales_with_discount DESC;

/*
Вывести наименование товара, его цену, год выпуска и остаток на складе для 
товаров, которых на складе осталось в 2 раза меньше, чем средний остаток товаров по трем брендам, для которых 
остатки самые большие. Отсортировать по убыванию остатка
*/
SELECT p.product_name, p.list_price, p.model_year, s.quantity
FROM production.products p
JOIN production.stocks s ON p.product_id = s.product_id
WHERE s.quantity < (
    (
        SELECT AVG(total_quantity * 1.0)
        FROM (
            SELECT TOP 3 SUM(i.quantity) total_quantity
            FROM production.products p2
            JOIN production.stocks i ON p2.product_id = i.product_id
            GROUP BY p2.brand_id
            ORDER BY total_quantity DESC
        ) top3
    ) / 2.0
)
ORDER BY s.quantity DESC;

/*
Вывести в результате запроса:
- наименование бренда, 
- сумму остатков на всех складах по товарам данного бренда
Результаты должны быть выведены для трех топ-брендов, для которых сумма остатков максимальна
*/ 
SELECT TOP 3 b.brand_name, SUM(s.quantity) total_stock
FROM production.brands b
JOIN production.products p ON b.brand_id = p.brand_id
JOIN production.stocks s ON p.product_id = s.product_id
GROUP BY b.brand_id, b.brand_name
ORDER BY total_stock DESC;

/*
Для предыдущей задачи рассчитать средний остаток по трем брендам
*/
SELECT AVG(total_stock * 1.0) AS avg_top3
FROM (
    SELECT TOP 3 SUM(s.quantity) AS total_stock
    FROM production.brands b
    JOIN production.products p ON b.brand_id = p.brand_id
    JOIN production.stocks s ON p.product_id = s.product_id
    GROUP BY b.brand_id
    ORDER BY total_stock DESC

) top3_brands;
