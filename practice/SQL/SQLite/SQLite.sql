/*Выгрузить из таблицы items все ноутбуки Dell (название производителя находится в поле vendor)*/
select * from items 
where vendor like 'Dell'

/*Выгрузить из таблицы items ноутбуки ASUS, HP и Acer*/
select * from items 
where vendor in ('ASUS', 'HP', 'Acer')

/*Выгрузить из таблицы items все товары ценой от 50000 до 60000 рублей.*/
select * from items 
where price between 50000 and 60000

/*Выгрузить из таблицы orders все заказы, которые были совершены после 2021.12.11 9:00 
(при написании условия на дату, дату нужно добавлять в кавычки '2021.12.11 9:00') 
или заказы в магазине с shop_id = 1564 и количеством товаров больше одного.*/
select * from orders 
where date > '2021.12.11 9:00' or shop_id = 1564 and amount > 1

/*Выгрузить данные из таблицы item_info (характеристики товаров), 
отсортированные по полю screen_size (размер экрана) по убыванию. И ограничить выгружаемый список в 10 строк*/
select * from item_info 
order by screen_size desc 
limit 10

/*Вывести клиентов (поле client_id), которые покупали ноутбуки Lenovo (поле vendor). 
В результирующей выборке должен быть только client_id. Использовать сокращенное название таблиц t1 и t2*/
select client_id 
from orders t1 
inner join items t2 on t1.item_id=t2.item_id 
where vendor like 'Lenovo'

/*Выгрузить название магазина (поле name) и сумму количества проданных товаров по каждому магазину (поле amount) с условием – 
только товары с объемом накопителя равным 256 (поле storage_capacity) и отсортировать данные по сумме проданных товаров по убыванию. 
Использовать сокращенное название таблиц t1, t2 и t3. Для зачета правильного ответа в select сделать название для суммы - items_amount.*/
select name, sum(amount) as items_amount 
from shops t1 
inner join orders t2 on t1.shop_id=t2.shop_id 
inner join item_info t3 on t2.item_id=t3.item_id 
where storage_capacity = 256 
group by name 
order by sum(amount) desc

/*Выгрузить данные в один столбец из поля vendor из таблицы items и поля processor из таблицы item_info, используя оператор UNION*/
select vendor 
from items 
union 
select processor 
from item_info

/*Выгрузить данные по поезду с самой ранней датой отправления, используя подзапрос в условии. 
В результирующей выборке нужно вывести все поля из таблицы trains, дату отправления и дату прибытия. 
Использовать сокращенное название таблиц t1 и t2.*/
select t1.date_from, t1.date_to, t2.* 
from routes t1 
join trains t2 on t1.train_id=t2.train_id 
where date_from = (select min(date_from) 
                    from routes)
/*Вывести количество поездов, на которые покупали билеты два раза. В решении необходимо использовать подзапрос. 
Также использовать сокращенное название таблиц t1 и t2. Для зачета правильного ответа в select сделать название для количества - trains_qty.*/
select count(train_id) as trains_qty 
from (select t2.train_id 
  from tickets t1 
  join routes t2 on t1.route_id=t2.route_id 
  group by t2.train_id 
  having count(ticket_id) =2)
