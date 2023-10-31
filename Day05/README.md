# Day 05

## Улучшение SQL-запросов

Создание индексов базы данных.

## Introduction

- Для написания программ использовалась версия 15.2 PostgreSQL.
- Исходный код писался в DataGrip IDE.

## Contents

1. [Exercise 00](#exercise-00)
2. [Exercise 01](#exercise-01)
3. [Exercise 02](#exercise-02)
4. [Exercise 03](#exercise-03)
5. [Exercise 04](#exercise-04)
6. [Exercise 05](#exercise-05)
7. [Exercise 06](#exercise-06)

## Rules of the day

- Убедитесь, что у вас есть собственная база данных и доступ к ней PostgreSQL.
- Загрузите [скрипт](materials/model.sql) с моделью базы данных здесь и примените его к своей базе данных. **Все изменения, которые были внесены в День 03 во время упражнений 07–13, должны быть на месте (это похоже на то, как в реальном мире, когда применяется выпуск, и необходимо обеспечить согласованность с данными для новых изменений).**
- Логическое представление предоставленной модели базы данных:

![schema](misc/images/schema.png)


1. **pizzeria** (Таблица с доступными пиццериями)
- поле id - первичный ключ
- поле name - название пиццерий
- поле rating - средний рейтинг пиццерии (от 0 до 5 баллов)
2. **person** (Таблица с людьми, которые любят пиццу)
- поле id - первичный ключ
- поле name - имя человека
- поле age - возраст человека
- поле gender - половая принадлежность человека
- поле address - адрес человека
3. **menu** (Таблица с доступным меню и ценой на конкретную пиццу)
- поле id - первичный ключ
- поле pizzeria_id - внешний ключ от таблицы пиццерий
- поле pizza_name - название пиццы в пиццерии
- поле price - цена конкретной пиццы
4. **person_visits** (Таблица с информацией о посещениях пиццерии)
- поле id - первичный ключ
- поле person_id - внешний ключ от таблицы с людьми
- поле pizzeria_id - внешний ключ от таблицы пиццерий
- поле visit_date - дата (например: 01.01.2022) посещения человека
5. **person_order** (Таблица с информацией о заказах людей)
- поле id - первичный ключ
- поле person_id - внешний ключ от таблицы с людьми
- поле menu_id - внешний ключ от таблицы с меню
- поле order_date - дата (например: 01.01.2022) заказа человека

Посещение человека и заказ человека являются разными сущностями и не содержат никакой корреляции между данными. Например, клиент может находиться в одном ресторане (просто просматривая меню), а в это время сделать заказ в другом по телефону или через мобильное приложение. Или другой случай, просто оказаться дома и снова позвонить с заказом без всяких посещений.

## Exercise 00

- Программа расположена в директории: ex00;
- Файл для сдачи: `day05_ex00.sql`;
- Языки: ANSI SQL.

Создан простой BTree индекс для каждого внешнего ключа в нашей базе данных. Шаблон имени должен удовлетворять следующему правилу «idx_{table_name}_{column_name}». Например, имя индекса BTree для столбца pizzeria_id в таблице `menu` — `idx_menu_pizzeria_id`.

## Exercise 01

- Программа расположена в директории: ex01;
- Файл для сдачи: `day05_ex01.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает названия пицц и соответствующих им пиццерий. Образец результата ниже (сортировка не требуется).

| pizza_name | pizzeria_name | 
| ------ | ------ |
| cheese pizza | Pizza Hut |
| ... | ... |

Для доказательства роботоспособности индексов используется SQL-запрос с командой `EXPLAIN ANALYZE`. Пример команды вывода представлен ниже.
    
    ...
    ->  Index Scan using idx_menu_pizzeria_id on menu m  (...)
    ...

## Exercise 02

- Программа расположена в директории: ex02;
- Файл для сдачи: `day05_ex02.sql`;
- Языки: ANSI SQL.

Написан код для создания функционального индекса B-дерева с именем `idx_person_name` для имени столбца таблицы `person`. Индекс содержит имена людей в верхнем регистре.

Написан SQL-запрос с доказательством (`EXPLAIN ANALYZE`) того, что индекс idx_person_name работает.

## Exercise 03

- Программа расположена в директории: ex03;
- Файл для сдачи: `day05_ex03.sql`;
- Языки: ANSI SQL.

Создан лучший индекс B-дерева с несколькими столбцами с именем `idx_person_order_multi` для оператора SQL ниже.

    SELECT person_id, menu_id,order_date
    FROM person_order
    WHERE person_id = 8 AND menu_id = 19;

Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон. Обратите внимание на сканирование "Index Only Scan"!

    Index Only Scan using idx_person_order_multi on person_order ...

Предоставлен SQL-запрос с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_person_order_multi` работает.

## Exercise 04

- Программа расположена в директории: ex04;
- Файл для сдачи: `day05_ex04.sql`;
- Языки: ANSI SQL.

Создан уникальный индекс BTree с именем `idx_menu_unique` в таблице `menu` для столбцов `pizzeria_id` и `pizza_name`.
Написан SQL-запрос с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_menu_unique` работает.

## Exercise 05

- Программа расположена в директории: ex05;
- Файл для сдачи: `day05_ex05.sql`;
- Языки: ANSI SQL.

Создан частично уникальный индекс BTree с именем `idx_person_order_order_date` в таблице `person_order` для атрибутов `person_id` и `menu_id` с частичной уникальностью для столбца `order_date` для даты `2022-01-01`.

Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон.

    Index Only Scan using idx_person_order_order_date on person_order …

## Exercise 06

- Программа расположена в директории: ex06;
- Файл для сдачи: `day05_ex06.sql`;
- Языки: ANSI SQL.

Пожалуйста, взгляните на SQL ниже с технической точки зрения (игнорируйте логический случай этого оператора SQL).

    SELECT
        m.pizza_name AS pizza_name,
        max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
    FROM  menu m
    INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
    ORDER BY 1,2;

Создан новый индекс BTree с именем `idx_1`, который должен улучшить показатель “Execution Time” этого SQL-запроса. Предоставлено доказательство (`EXPLAIN ANALYZE`) того, что SQL был улучшен.

**Подсказка**: это упражнение похоже на задачу «грубой силы» по поиску хорошего покрывающего индекса, поэтому перед новым тестом необходимо удалить индекс `idx_1`.

Пример улучшения:

**Before**:

    Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
            ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
                Sort Key: pz.rating
                Sort Method: quicksort  Memory: 26kB
                ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
                        Merge Cond: (m.pizzeria_id = pz.id)
                        ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
                            Heap Fetches: 19
                        ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
    Planning Time: 0.711 ms
    Execution Time: 0.338 ms

**After**:

    Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
    "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
    Sort Method: quicksort  Memory: 26kB
    ->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
            ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
                ->  Index Scan using idx_1 on …
                ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
    …
    Planning Time: 0.338 ms
    Execution Time: 0.203 ms

