/*Определить города, в которых проживают клиенты, оформлявшие заказы в интернет-магазине.
Для каждого такого города рассчитать общее количество заказов.
Результат отсортировать сначала по убыванию числа заказов, затем — по названию города в алфавитном порядке.*/
SELECT name_city, count(city.city_id) AS Количество
FROM city   
    RIGHT JOIN client ON city.city_id = client.city_id  
    RIGHT JOIN buy ON buy.client_id = client.client_id
GROUP BY city.city_id
ORDER BY Количество DESC, name_city;

/*Вывести текущий этап обработки для каждого активного заказа.
Активными считаются заказы, у которых этап начался (указана дата начала), но ещё не завершён (дата окончания отсутствует).
Заказы, уже доставленные (или завершённые), не включать.
Результат отсортировать по возрастанию идентификатора заказа.*/
SELECT buy_id, name_step
FROM buy_step
    JOIN step USING(step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
ORDER BY buy_id;

/*Найти жанр (или жанры), в котором было продано наибольшее общее количество экземпляров книг.
Указать название жанра и соответствующее количество проданных книг.*/
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

/*Сравнить ежемесячную выручку от продаж книг за два последних года (включая текущий и предыдущий).
Для каждого месяца вывести год, название месяца и сумму выручки.
Результат отсортировать сначала по месяцам (в хронологическом порядке), затем — по возрастанию года.*/
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

/*Для каждой книги рассчитать общее количество проданных экземпляров и выручку за 2019 и 2020 годы.
Продажи за 2020 год включают только те заказы, которые уже прошли этап оплаты.
Данные за 2019 год берутся из архива завершённых заказов.
Итоговую информацию отсортировать по убыванию общей выручки.*/
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
