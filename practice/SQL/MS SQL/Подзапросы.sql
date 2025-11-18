/*выберите из таблицы товаров наименовани€ и цены всех товаров, которые есть в количестве более 20 шт. (quantity) 
на складе 2 магазина (store_id=2). ќтсортируйте по наименованию товара*/
SELECT t1.product_name, t1.list_price
FROM production.products t1
WHERE t1.product_id IN (
  SELECT t2.product_id
  FROM production.stocks t2
  WHERE t2.store_id = 2 AND t2.quantity > 20)
ORDER BY t1.product_name

/*¬ывести номер заказа, дату заказа и общую сумму заказа с учетом скидки, но только по тем заказам, которые принимал 
менеджер с id = 3. —ортировать по убыванию общей суммы заказа с учетом скидки*/
SELECT t2.order_id, t2.customer_id, (
  SELECT SUM(t1.quantity*t1.list_price*(1-t1.discount))
  FROM sales.order_items t1
  WHERE t1.order_id = t2.order_id) total_amount
FROM sales.orders t2
WHERE staff_id = 3
ORDER BY total_amount DESC

/*¬ывести номер заказа, дату заказа и максимальную сумму скидки (среди всех позиций в заказе), которую по данному 
заказу получил клиент. —ортировать по номеру заказа по возрастанию.*/
SELECT t1.order_id, t1.order_date, (
        SELECT MAX(t2.quantity * t2.list_price * t2.discount)
        FROM sales.order_items t2
        WHERE t2.order_id = t1.order_id) max_discount
FROM sales.orders t1
ORDER BY t1.order_id

/*¬ывести наименование, год выпуска и цену товара, но только дл€ товаров категории "детские велосипеды". 
»спользуйте вложенный запрос с IN. ”пор€дочить по убыванию цены.*/
SELECT product_name, model_year, list_price
FROM production.products
WHERE category_id IN (
        SELECT category_id
        FROM production.categories
        WHERE category_name = 'Children Bicycles')
ORDER BY list_price DESC