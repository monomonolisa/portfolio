/*Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. 
Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.*/
SELECT name_city, count(city.city_id) AS Количество
FROM city   
    RIGHT JOIN client ON city.city_id = client.city_id  
    RIGHT JOIN buy ON buy.client_id = client.client_id
GROUP BY city.city_id
ORDER BY Количество DESC, name_city;
-- Query result:
+-----------------+------------+
| name_city       | Количество |
+-----------------+------------+
| Владивосток     | 2          |
| Москва          | 1          |
| Санкт-Петербург | 1          |
+-----------------+------------+

/*Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. 
Информацию отсортировать по возрастанию buy_id.*/
SELECT buy_id, name_step
FROM buy_step
    JOIN step USING(step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
ORDER BY buy_id;
-- Query result:
+--------+-----------------+
| buy_id | name_step       |
+--------+-----------------+
| 2      | Транспортировка |
| 3      | Доставка        |
| 4      | Оплата          |
+--------+-----------------+

-- Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество . Последний столбец назвать Количество.
SELECT 
    name_genre,
    SUM(buy_book.amount) AS Количество
FROM genre
JOIN book ON book.genre_id = genre.genre_id
JOIN buy_book ON buy_book.book_id = book.book_id
GROUP BY name_genre
HAVING SUM(buy_book.amount) = (
    SELECT MAX(total_amount)
    FROM (
        SELECT SUM(buy_book.amount) AS total_amount
        FROM book
        JOIN buy_book ON buy_book.book_id = book.book_id
        GROUP BY book.genre_id
    ) AS tutut
);
-- Query result:
+------------+------------+
| name_genre | Количество |
+------------+------------+
| Роман      | 7          |
+------------+------------+

/*Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, 
сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.*/
SELECT YEAR(buy_step.date_step_end) AS Год, MONTHNAME(buy_step.date_step_end) AS Месяц, SUM(buy_book.amount * book.price) AS Сумма
FROM buy_book
    INNER JOIN book USING (book_id)
    INNER JOIN buy ON buy.buy_id = buy_book.buy_id
    INNER JOIN buy_step ON buy_book.buy_id = buy_step.buy_id
WHERE step_id = 1 AND date_step_end IS NOT NULL
GROUP BY 2, 1
UNION ALL
SELECT YEAR(buy_archive.date_payment) AS Год, MONTHNAME(buy_archive.date_payment) AS Месяц, SUM(buy_archive.amount * buy_archive.price) AS Сумма
FROM buy_archive
   
GROUP BY 2, 1
ORDER BY 2, 1
-- Query result:
+------+----------+---------+
| Год  | Месяц    | Сумма   |
+------+----------+---------+
| 2019 | February | 5626.30 |
| 2020 | February | 3309.37 |
| 2019 | March    | 6857.50 |
| 2020 | March    | 2131.49 |
+------+----------+---------+

/*Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год . 
За 2020 год проданными считать те экземпляры, которые уже оплачены. Вычисляемые столбцы назвать Количество и Сумма. 
Информацию отсортировать по убыванию стоимости.*/
SELECT 
    title,
    SUM(Количество) AS Количество,
    SUM(Сумма) AS Сумма
FROM (
    SELECT 
        book.title AS title,
        SUM(buy_book.amount) AS Количество,
        SUM(buy_book.amount * book.price) AS Сумма
    FROM buy_book
    JOIN book ON book.book_id = buy_book.book_id
    JOIN buy ON buy.buy_id = buy_book.buy_id
    JOIN buy_step ON buy_step.buy_id = buy.buy_id
    JOIN step ON step.step_id = buy_step.step_id
    WHERE step.name_step = 'Оплата'
      AND buy_step.date_step_end IS NOT NULL
      AND YEAR(buy_step.date_step_end) = 2020
    GROUP BY book.title

    UNION ALL

    SELECT 
        book.title AS title,
        SUM(buy_archive.amount) AS Количество,
        SUM(buy_archive.price * buy_archive.amount) AS Сумма
    FROM buy_archive
    JOIN book ON book.book_id = buy_archive.book_id
    WHERE YEAR(buy_archive.date_payment) = 2019
    GROUP BY book.title
) AS combined
GROUP BY title
ORDER BY Сумма DESC;
-- Query result:
+-----------------------+------------+---------+
| title                 | Количество | Сумма   |
+-----------------------+------------+---------+
| Братья Карамазовы     | 8          | 6247.20 |
| Мастер и Маргарита    | 6          | 4024.38 |
| Идиот                 | 5          | 2281.80 |
| Белая гвардия         | 3          | 1581.10 |
| Черный человек        | 2          | 1140.40 |
| Лирика                | 2          | 1037.98 |
| Игрок                 | 2          | 961.80  |
| Стихотворения и поэмы | 1          | 650.00  |
+-----------------------+------------+---------+
