-- Создать таблицу fine
CREATE TABLE fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8, 2),
    date_violation DATE,
    date_payment DATE
);

/*Добавить в таблицу три новые записи о нарушениях, оставив сумму штрафа и дату оплаты неопределёнными (NULL).*/
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
    ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
    ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL), 
    ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

/*Выявить водителей, которые на одном и том же транспортном средстве совершили одно и то же нарушение два или более раза (независимо от статуса оплаты).
Для каждого такого случая вывести фамилию и инициалы водителя, госномер автомобиля и тип нарушения.
Результат отсортировать по фамилии водителя, затем по номеру автомобиля и, наконец, по нарушению — в алфавитном порядке.*/
SELECT name, number_plate, violation
FROM fine
GROUP BY name, number_plate, violation
HAVING count(*)>1
ORDER BY name, number_plate, violation;

/*Для всех неоплаченных штрафов, выявленных в предыдущем запросе (повторяющиеся нарушения одним водителем на одном автомобиле), увеличить сумму штрафа в два раза.
Обновление должно затрагивать только те записи, где дата оплаты отсутствует.*/
UPDATE fine AS f, (
	   SELECT name, number_plate, violation
  		 FROM fine
 		GROUP BY name, number_plate, violation
	   HAVING count(*) >= 2
	   ) AS dv
   SET f.sum_fine = f.sum_fine*2
 WHERE f.date_payment IS Null
	   AND (f.name = dv.name
	   AND f.violation = dv.violation);
SELECT * FROM fine;
