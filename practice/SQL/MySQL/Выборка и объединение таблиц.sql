-- Создать таблицу author
CREATE TABLE author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

-- Заполнить таблицу author. В нее включить следующих авторов: Булгаков М.А., Достоевский Ф.М., Есенин С.А., Пастернак Б.Л.
INSERT INTO author (author_id, name_author)
VALUES
    (1, 'Булгаков М.А.'),
    (2, 'Достоевский Ф.М.'),
    (3, 'Есенин С.А.'),
    (4, 'Пастернак Б.Л.');

/*Создать таблицу для хранения данных о книгах в соответствии с заданной структурой базы данных.
Таблица должна включать внешние ключи, связывающие книгу с автором и жанром.
Поле, ссылающееся на жанр, может содержать пустые значения.*/
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2),
    amount INT,
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

/*Отобрать книги, количество экземпляров которых на складе превышает 8 штук.
Для каждой такой книги вывести название, жанр и цену.
Результат отсортировать по убыванию цены.*/
SELECT title, name_genre, price
FROM book 
INNER JOIN author ON author.author_id = book.author_id
INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE amount > 8
ORDER BY price DESC;

/*Определить жанры, которые отсутствуют среди книг на складе (т.е. нет ни одной книги, отнесённой к этим жанрам).
Вывести только названия таких жанров.*/
SELECT name_genre
FROM genre LEFT JOIN book
    ON genre.genre_id = book.genre_id
WHERE book.genre_id IS NULL;

/*Найти все книги, отнесённые к жанрам, в названии которых содержится слово «Роман» (с учётом регистра или без — в зависимости от настроек СУБД).
Вывести жанр, название книги и имя автора.
Результат отсортировать по алфавиту названий книг.*/
SELECT 
    g.name_genre,
    b.title,
    a.name_author
FROM 
    genre g
    INNER JOIN book b ON g.genre_id = b.genre_id
    INNER JOIN author a ON a.author_id = b.author_id
WHERE 
    g.name_genre LIKE '%Роман%'
ORDER BY 
    b.title;

/*Рассчитать общее количество экземпляров книг для каждого автора.
Включить в результат даже тех авторов, чьи книги отсутствуют на складе (количество = NULL или 0).
Отобразить только тех, у кого общее количество книг меньше 10.
Отсортировать результат по возрастанию количества экземпляров.*/
SELECT name_author, SUM(amount) AS Количество
FROM author LEFT JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING Количество < 10 OR Количество IS NULL
ORDER BY Количество;
