/*Создать таблицу поставок (supply), которая имеет ту же структуру, что и таблиц book.*/
CREATE TABLE supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8,2),
    amount INT
);

/*Заполнить её четырьмя записями, содержащими название книги, имя автора, цену и количество экземпляров.*/
INSERT INTO supply (supply_id, title, author, price, amount)
VALUES
    (1, 'Лирика', 'Пастернак Б.Л.', 518.99, 2),
    (2, 'Черный человек', 'Есенин С.А.', 570.20, 6),
    (3, 'Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    (4, 'Идиот', 'Достоевский Ф.М.', 360.80, 3);

/*Перенести из таблицы поставок (supply) в основной каталог (book) все книги, за исключением произведений М.А. Булгакова и Ф.М. Достоевского.*/
INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN ('Булгаков М.А.', 'Достоевский Ф.М.');

/*Привести данные в таблице book в соответствие с реальными возможностями продаж:
— если количество заказанных покупателем экземпляров (buy) превышает остаток на складе (amount), ограничить его значением остатка;
— если книга не была заказана (buy = 0), снизить её цену на 10%.*/
UPDATE book SET buy = if (buy > amount, amount, buy),
                price = if (buy = 0, price * 0.9, price);
SELECT * FROM book;

/*Для книг, присутствующих одновременно в каталоге (book) и в поставке (supply):
— увеличить остаток в каталоге на количество из поставки;
— пересчитать цену как среднее арифметическое между текущей ценой и ценой из поставки.*/
UPDATE book, supply
SET 
    book.amount = book.amount + supply.amount,
    book.price = (supply.price + book.price)/2
WHERE book.title = supply.title

/*Удалить из таблицы поставок (supply) все записи о книгах тех авторов, суммарное количество экземпляров которых в основном каталоге (book) превышает 10 штук.*/
DELETE FROM supply
WHERE author IN (
    SELECT author
    FROM book
    GROUP BY author
    HAVING SUM(amount) > 10
);
