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

/*Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме 
(таблица genre уже создана, порядок следования столбцов - как на логической схеме в таблице book, genre_id  - внешний ключ). 
Для genre_id ограничение о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля  genre_id
использовать таблицу genre следующей структуры:*/
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

-- Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.
SELECT title, name_genre, price
FROM book 
INNER JOIN author ON author.author_id = book.author_id
INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE amount > 8
ORDER BY price DESC;

-- Вывести все жанры, которые не представлены в книгах на складе.
SELECT name_genre
FROM genre LEFT JOIN book
    ON genre.genre_id = book.genre_id
WHERE book.genre_id IS NULL;

--  Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.
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

/* Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, 
в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.*/
SELECT name_author, SUM(amount) AS Количество
FROM author LEFT JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING Количество < 10 OR Количество IS NULL
ORDER BY Количество;
