/*Выведите все столбцы из таблицы клиентов.*/
SELECT * FROM sales.customers

/*Выведите все столбцы из таблицы товаров для товары модельного года 2017 их наименования и цену по прайсу.*/
SELECT product_name Наименование, list_price Цена 
FROM production.products
WHERE model_year = 2017

/*Выведите для таблицы клиентов фамилию и имя в одном столбце под псевдонимом "FIO", а также телефон и город. 
Упорядочить по фамилии клиента. Вывести только первые 25 клиентов.*/
SELECT TOP 25 first_name+' '+last_name FIO, phone, city
FROM sales.customers
ORDER BY last_name

/*Выведите для таблицы клиентов только первые 10 клиентов, для которых номер телефона не является пустым. 
Отсортировать по фамилии клиента в алфавитном порядке по возрастанию.*/
SELECT TOP 10 * FROM sales.customers
WHERE phone IS NOT NULL
ORDER BY last_name

/*Выведите фамилию, имя телефон клиентов, проживающих в одном из штатов: “TX” или “CA”. 
Отсортировать по фамилии клиента в алфавитном порядке по возрастанию.*/
SELECT last_name, first_name, phone
FROM sales.customers
WHERE state IN ('TX', 'CA')
ORDER BY last_name

/*Выведите наименование товара, цену и год выхода на рынок, 
но только для товаров с ценой не более 300 и не менее 800 у.е., относящиеся к бренду с brand_id = 1. 
Отсортировать по наименованию товара по возрастанию.*/
SELECT product_name, list_price, model_year
FROM production.products
WHERE (list_price>= 800 OR list_price<= 300) AND brand_id = 1
ORDER BY product_name

/*Выведите количество клиентов в каждом штате, которые пользуются эл. почтой hotmail. 
Сортировать по аббревиатуре штата в алфавитном порядке.*/
SELECT state Штат, COUNT(customer_id) Количество_клиентов
FROM sales.customers
WHERE email LIKE '%hotmail%'
GROUP BY state
ORDER BY state