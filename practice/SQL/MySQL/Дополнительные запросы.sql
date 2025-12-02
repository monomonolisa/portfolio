/*Найти книги, которые присутствуют одновременно в таблицах book и supply, причём совпадают как название, так и цена.
Для каждой такой книги вывести название, автора и общее количество экземпляров (сумма из обеих таблиц).
Столбцы результата назвать: Название, Автор, Количество.*/
SELECT book.title Название, name_author Автор, SUM(book.amount+supply.amount) Количество
FROM author
    INNER JOIN book USING(author_id)
    INNER JOIN supply ON book.title = supply.title and book.price=supply.price
GROUP BY book.title, name_author;    

/*Добавить в справочник авторов (author) новых авторов, которые указаны в поставках (supply), но отсутствуют в текущем списке авторов.
После добавления вывести полное содержимое таблицы author.*/
INSERT INTO author (name_author)
SELECT supply.author
FROM
    author
    RIGHT JOIN supply ON author.name_author = supply.author
WHERE author.name_author IS Null;

/*Перенести из таблицы поставок (supply) в основной каталог книг (book) все новые книги (от авторов, уже добавленных в author), у которых количество экземпляров больше нуля.
После вставки вывести обновлённое содержимое таблицы book.*/
INSERT INTO book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM 
    author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;

/*Назначить жанры для двух конкретных книг:
— «Стихотворения и поэмы» М.Ю. Лермонтова отнести к жанру «Поэзия»,
— «Остров сокровищ» Р.Л. Стивенсона — к жанру «Приключения».
Обновление выполнить с использованием связки по названию жанра и имени автора.*/
UPDATE book
SET genre_id = (
  SELECT genre_id 
  FROM genre
  WHERE name_genre = "Поэзия"
)
WHERE title = "Стихотворения и поэмы" AND book.author_id = (SELECT author_id
FROM author
WHERE name_author = "Лермонтов М.Ю.");
UPDATE book
SET genre_id = (
  SELECT genre_id 
  FROM genre
  WHERE name_genre = "Приключения"
)
WHERE title = "Остров сокровищ" AND book.author_id = (SELECT author_id
FROM author
WHERE name_author = "Стивенсон Р.Л.");
SELECT * FROM book;

/*Удалить из базы данных всех авторов, чьи книги относятся к жанру «Поэзия», а также удалить все книги этих авторов из каталога.
При отборе использовать название жанра, а не его идентификатор.*/
DELETE FROM author
USING 
    author
    INNER JOIN book ON author.author_id = book.author_id
WHERE genre_id = (
    SELECT genre_id
    FROM genre
    WHERE name_genre = 'Поэзия');
SELECT * FROM book;
