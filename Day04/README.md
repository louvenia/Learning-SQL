# Day 04

## Материализованные и виртуальные таблицы

Использование виртуальных и материализованных представлений данных.

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
8. [Exercise 07](#exercise-07)
9. [Exercise 08](#exercise-08)

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
- Файл для сдачи: `day04_ex00.sql`;
- Языки: ANSI SQL.

Написан код для создания 2 представлений базы данных (с атрибутами, аналогичными исходной таблице) на основе простой фильтрации по полу людей. Заданы соответствующие имена для представлений базы данных: `v_persons_female` и `v_persons_male`.

## Exercise 01

- Программа расположена в директории: ex01;
- Файл для сдачи: `day04_ex01.sql`;
- Языки: ANSI SQL.

Написаны SQL запросы с использованием 2 представлений из упражнения 00, чтобы получить имена женщин и мужчин в одном списке. Результат упорядочен по имени человека. Пример данных представлен ниже.

| name |
| ------ |
| Andrey |
| Anna |
| ... |

## Exercise 02

- Программа расположена в директории: ex02;
- Файл для сдачи: `day04_ex02.sql`;
- Языки: ANSI SQL;
- SQL синтаксические конструкции: `generate_series(...)`.

Написан код для создания представления базы данных (с именем `v_generated_dates`), в котором «сохранены» сгенерированные даты с 1 по 31 января 2022 года в типе DATE. Результат упорядочен по столбцу сгенерированной_даты.

| generated_date |
| ------ |
| 2022-01-01 |
| 2022-01-02 |
| ... |

## Exercise 03

- Программа расположена в директории: ex03;
- Файл для сдачи: `day04_ex03.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает пропущенные дни для посещений людей в январе 2022 года. С использованием представления `v_generated_dates` для этой задачи и результат отсортирован по столбцу `Missing_date`. Пример данных представлен ниже.

| missing_date |
| ------ |
| 2022-01-11 |
| 2022-01-12 |
| ... |

## Exercise 04

- Программа расположена в директории: ex04;
- Файл для сдачи: `day04_ex04.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который удовлетворяет формуле `(R - S)∪(S - R)` .
Где R — это таблица «`person_visits`» с фильтром на 2 января 2022 года, S — это также таблица «`person_visits`», но с другим фильтром на 6 января 2022 года. Созданы расчеты с наборами в столбце «`person_id`», и этот столбец будет единственным в результате. Результат отсортирован по столбцу `person_id`, а окончательный SQL-код указан в представлении базы данных `v_symmetric_union` (*).

(*) честно говоря, определения «симметричное объединение» не существует в теории множеств. Это авторская интерпретация, основная идея которой основана на существующем правиле симметричного различия.

## Exercise 05

- Программа расположена в директории: ex05;
- Файл для сдачи: `day04_ex05.sql`;
- Языки: ANSI SQL.

Написан код для создания представления базы данных `v_price_with_discount`, которое возвращает заказы человека с именами людей, названиями пиццы, реальной ценой и расчетным столбцом `discount_price` (с примененной скидкой 10 % и удовлетворяет формуле «цена - цена*0,1»). Результат отсортирован по имени человека и названию пиццы и столбец `discount_price` округлен до целочисленного типа. Образец результата представлен ниже.

| name |  pizza_name | price | discount_price |
| ------ | ------ | ------ | ------ | 
| Andrey | cheese pizza | 800 | 720 | 
| Andrey | mushroom pizza | 1100 | 990 |
| ... | ... | ... | ... |

## Exercise 06

- Программа расположена в директории: ex06;
- Файл для сдачи: `day04_ex06.sql`;
- Языки: ANSI SQL.

Написан код для создания материализованного представления `mv_dmitriy_visits_and_eats` (с включенными данными) на основе оператора SQL, которое находит название пиццерии, которую Дмитрий посетил 8 января 2022 года и где он мог есть пиццу менее чем за 800 рублей (этот SQL запрос находится в 02 дне и упражнении № 07).

Для проверки можно написать SQL запрос в материализованном представлении `mv_dmitriy_visits_and_eats` и сравнить результаты с предыдущим запросом.

## Exercise 07

- Программа расположена в директории: ex07;
- Файл для сдачи: `day04_ex07.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- SQL синтаксические конструкции: нельзя использовать точные номера для идентификаторов первичного ключа, person и pizzeria.

Написан код для обновления данных в материализованном представлении `mv_dmitriy_visits_and_eats` из упражнения №06. Перед этим действием необходимо сгенерировать еще одно посещение Дмитрия, которое удовлетворяет предложению SQL материализованного представления, за исключением пиццерии, которую мы видим в результате упражнения № 06.
После добавления нового посещения необходимо обновить состояние данных для `mv_dmitriy_visits_and_eats`.

## Exercise 08

- Программа расположена в директории: ex08;
- Файл для сдачи: `day04_ex08.sql`;
- Языки: ANSI SQL.       

После всех упражнений созданы несколько виртуальных таблиц и одно материализованное представление. В этом упражнении написан код для их удаления.
