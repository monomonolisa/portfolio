/*Добавить нового клиента в базу: Попов Илья, электронная почта popov@test, проживает в Москве.
После добавления вывести обновлённый список клиентов.*/
INSERT INTO client (name_client, city_id, email)
SELECT 'Попов Илья', city_id , 'popov@test'
FROM city
WHERE name_city = 'Москва';
SELECT * FROM client;

/*Создать новый заказ для клиента Попова Ильи с комментарием: «Связаться со мной по вопросу доставки».*/
INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья';

/*Оформить содержимое заказа №5: включить в него 2 экземпляра книги «Лирика» Б.Л. Пастернака и 1 экземпляр книги «Белая гвардия» М.А. Булгакова.
После добавления вывести полный список позиций заказов.*/
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, (
    SELECT book_id
    FROM book
    WHERE title = 'Лирика' AND author_id = (SELECT author_id
                                            FROM author 
                                            WHERE name_author LIKE '%Пастернак%')
), 2;
INSERT INTO buy_book (buy_id, book_id, amount)
SELECT 5, (
    SELECT book_id
    FROM book
    WHERE title = 'Белая гвардия' AND author_id = (SELECT author_id
                                                   FROM author 
                                                   WHERE name_author LIKE '%Булгаков%')
), 1;
SELECT * FROM buy_book;

/*Обновить остатки на складе: уменьшить количество экземпляров книг, включённых в заказ №5, на соответствующие количества из этого заказа.*/
UPDATE book
JOIN buy_book ON buy_book.book_id = book.book_id
SET book.amount = book.amount - buy_book.amount
WHERE buy_book.buy_id = 5;

/*Завершить этап «Оплата» для заказа №5, указав дату завершения 13.04.2020, и одновременно инициировать следующий этап — «Упаковка», установив для него ту же дату начала.
Запросы должны быть универсальными и применимыми к любому текущему этапу при изменении только его названия.*/
UPDATE buy_step
SET date_step_end = '2020-04-13'
WHERE buy_id = 5 AND step_id = (SELECT step_id FROM step WHERE name_step = 'Оплата');
UPDATE buy_step
SET date_step_beg = '2020-04-13'
WHERE buy_id = 5 AND step_id = (SELECT step_id+1 FROM step WHERE name_step = 'Оплата');

/*Сформировать счёт на оплату для заказа №5.
В счёт включить название книги, имя автора, цену за экземпляр, количество и итоговую стоимость по каждой позиции.
Данные отсортировать по названию книг.*/
CREATE TABLE buy_pay (
    title VARCHAR(100),
    author_name VARCHAR(100),
    price DECIMAL(8,2),
    amount INT,
    Стоимость DECIMAL(8,2)
);
INSERT INTO buy_pay (title, author_name, price, amount, Стоимость)
SELECT title, name_author, price, buy_book.amount, buy_book.amount*price
FROM author
JOIN book ON author.author_id = book.author_id
JOIN buy_book ON book.book_id = buy_book.book_id
WHERE buy_book.buy_id = 5
ORDER BY title;
