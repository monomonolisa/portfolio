/*Выбрать все товары из каталога, произведённые компанией Dell.
Производитель указан в поле vendor.*/
select * from items 
where vendor like 'Dell'

/*Получить список всех ноутбуков, выпущенных компаниями ASUS, HP или Acer.
Определение производителя выполняется по полю vendor.*/
select * from items 
where vendor in ('ASUS', 'HP', 'Acer')

/*Отфильтровать товары с ценой в диапазоне от 50 000 до 60 000 рублей включительно.*/
select * from items 
where price between 50000 and 60000

/*Выбрать заказы, удовлетворяющие хотя бы одному из условий:
— совершены позже 11 декабря 2021 года в 9:00;
— оформлены в магазине с идентификатором shop_id = 1564 и содержат более одного товара.*/
select * from orders 
where date > '2021.12.11 9:00' or shop_id = 1564 and amount > 1

/*Получить топ-10 товаров с наибольшим размером экрана.
Данные берутся из таблицы характеристик (item_info) и сортируются по убыванию значения screen_size.*/
select * from item_info 
order by screen_size desc 
limit 10

/*Определить идентификаторы клиентов, которые приобретали ноутбуки бренда Lenovo.
Связь между заказами и товарами осуществляется через идентификатор товара.*/
select client_id 
from orders t1 
inner join items t2 on t1.item_id=t2.item_id 
where vendor like 'Lenovo'

/*Рассчитать общее количество проданных товаров по каждому магазину, но только для устройств с объёмом накопителя 256 ГБ.
Результат включает название магазина и сумму продаж (items_amount), отсортированную по убыванию.*/
select name, sum(amount) as items_amount 
from shops t1 
inner join orders t2 on t1.shop_id=t2.shop_id 
inner join item_info t3 on t2.item_id=t3.item_id 
where storage_capacity = 256 
group by name 
order by sum(amount) desc

/*Объединить в один список названия производителей из таблицы товаров и модели процессоров из таблицы характеристик.
Дубликаты автоматически исключаются (поведение UNION по умолчанию).*/
select vendor 
from items 
union 
select processor 
from item_info

/*Найти поезд с самой ранней датой отправления.
Вывести всю информацию о поезде, а также даты отправления и прибытия из расписания.*/
select t1.date_from, t1.date_to, t2.* 
from routes t1 
join trains t2 on t1.train_id=t2.train_id 
where date_from = (select min(date_from) 
                    from routes)
/*Подсчитать количество поездов, на которые было оформлено ровно два билета.
Использовать подзапрос для группировки и фильтрации по количеству билетов.*/
select count(train_id) as trains_qty 
from (select t2.train_id 
  from tickets t1 
  join routes t2 on t1.route_id=t2.route_id 
  group by t2.train_id 
  having count(ticket_id) =2)
