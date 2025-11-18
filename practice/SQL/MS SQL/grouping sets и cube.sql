/*Создать новую таблицу (отношение), в котором будет четыре атрибута: название бренда, название категории,
название магазина (store_name) и четвертый - это сумма остатков всех товаров (их количество)*/
SELECT t3.brand_name, t4.category_name, t5.store_name, COUNT(t1.quantity) total
INTO new_table
FROM production.stocks t1
JOIN production.products t2 ON t1.product_id = t2.product_id
JOIN production.brands t3 ON t2.brand_id = t3.brand_id
JOIN production.categories t4 ON t2.category_id = t4.category_id
JOIN sales.stores t5 ON t1.store_id = t5.store_id
GROUP BY t3.brand_name, t4.category_name, t5.store_name

/*Пользуясь созаданной в п.1 таблицей, создать запрос, который выводит количество остатков на 
всех складах (store), в том числе в разрезе по брендами категориям 
Использовать grouping sets*/
SELECT brand_name, category_name, SUM(total) AS total_quantity
FROM new_table
GROUP BY GROUPING SETS (
        (),                    
        (brand_name),          
        (category_name),       
        (brand_name, category_name)  
)
ORDER BY brand_name, category_name

/*Выполнить п.2, но использовать CUBE*/
SELECT brand_name, category_name, SUM(total) AS total_quantity
FROM new_table
GROUP BY CUBE(brand_name, category_name)
ORDER BY brand_name, category_name