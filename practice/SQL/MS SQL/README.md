# Microsoft SQL Server: Создание и анализ базы данных BikeStores

В этой папке собраны практические задания по работе с **Microsoft SQL Server**.  

## Содержимое папки

### Подготовка базы

- [`1-BikeStores-create objects.sql`](https://github.com/monomonolisa/portfolio/blob/9460bda6ee4ab6027b28e8b0d33e26bd5b32dfb2/practice/SQL/MS%20SQL/1-BikeStores-create%20objects.sql) — создание схем (`production`, `sales`) и таблиц с первичными/внешними ключами.
- [`2-BikeStores-load data.sql`](https://github.com/monomonolisa/portfolio/blob/9460bda6ee4ab6027b28e8b0d33e26bd5b32dfb2/practice/SQL/MS%20SQL/2-BikeStores-load%20data.sql) — загрузка реальных данных (бренды, категории, товары, заказы и т.д.).
- [`3-BikeStores-drop all objects.sql`](https://github.com/monomonolisa/portfolio/blob/9460bda6ee4ab6027b28e8b0d33e26bd5b32dfb2/practice/SQL/MS%20SQL/3-BikeStores-drop%20all%20objects.sql) — очистка базы для повторного использования.

### ER-диаграмма

- [`Схема связей.png`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/%D0%A1%D1%85%D0%B5%D0%BC%D0%B0%20%D1%81%D0%B2%D1%8F%D0%B7%D0%B5%D0%B9.png) — визуальная схема связей между таблицами (`sales.orders`, `production.products`, `sales.staffs` и др.).  

### Запросы

- [`join.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/join.sql) — соединения таблиц (INNER, LEFT).
- [`Подзапросы.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/%D0%9F%D0%BE%D0%B4%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D1%8B.sql) — вложенные запросы.
- [`Задания на CTE.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%20CTE.sql) — использование обобщённых табличных выражений (WITH).
- [`Задания на HAVING.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/%D0%97%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%20%D0%BD%D0%B0%20HAVING.sql) — фильтрация группировок.
- [`grouping sets и cube.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/grouping%20sets%20%D0%B8%20cube.sql) — расширенная группировка.
- [`Простые запросы на вывод.sql`](https://github.com/monomonolisa/portfolio/blob/c98546d75816e44330761ad5220b38bc5cdfa4f2/practice/SQL/MS%20SQL/%D0%9F%D1%80%D0%BE%D1%81%D1%82%D1%8B%D0%B5%20%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D1%8B%20%D0%BD%D0%B0%20%D0%B2%D1%8B%D0%B2%D0%BE%D0%B4.sql) — базовые SELECT, WHERE, ORDER BY.

## Что я умею

- Создавать структуру базы данных с использованием `CREATE SCHEMA`, `CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`.
- Загружать данные через `INSERT INTO`.
- Писать сложные запросы на основе ER-диаграммы.
- Использовать:
  - JOIN для соединения нескольких таблиц.
  - Подзапросы для фильтрации и вычислений.
  - CTE для структурирования логики.
  - HAVING для фильтрации групп.
  - GROUPING SETS / CUBE для многомерного анализа.
- Работать с датами, вычисляемыми полями, агрегатами.

## Примеры решённых задач

- Вывод среднего и максимального числа заказов на клиента.
- Расчёт суммарных продаж с учётом скидок за 2018 год по брендам.
- Поиск товаров с остатком в 2 раза меньше среднего по топ-брендам.
- Определение топ-3 брендов по объёму остатков.
- Использование CTE для разделения сложной логики на блоки.

Все запросы протестированы в **SQL Server Management Studio (SSMS)**.
