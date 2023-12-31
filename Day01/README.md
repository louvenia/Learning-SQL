# Day 01

## Первые шаги работы с множествами и соединениями JOIN в SQL

Получение необходимых данных на основе конструкций множеств и простых JOIN-соединений.

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
10. [Exercise 09](#exercise-09)
11. [Exercise 10](#exercise-10)

## Rules of the day

- Убедитесь, что у вас есть собственная база данных и доступ к ней PostgreSQL.
- Загрузите [скрипт](materials/model.sql) с моделью базы данных здесь и примените его к своей базе данных.
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
- Файл для сдачи: `day01_ex00.sql`;
- Языки: ANSI SQL.

Написаны операторы SQL, которые возвращают идентификатор меню и названия пиццы из таблицы «`menu`», а также идентификатор человека и имя человека из таблицы «`person`» в одном глобальном списке (с именами столбцов, как показано в примере ниже), упорядоченном по object_id, а затем по object_name.

| object_id | object_name |
| ------ | ------ |
| 1 | Anna |
| 1 | cheese pizza |
| ... | ... |

## Exercise 01

- Программа расположена в директории: ex01;
- Файл для сдачи: `day01_ex01.sql`;
- Языки: ANSI SQL.

Изменен оператор SQL из «упражнения 00», удалив столбец object_id. Затем изменен порядок по имени объекта для части данных из таблицы «`person`», а затем из таблицы «`menu`» (как показано в примере ниже). Дубликаты сохранены.

| object_name |
| ------ |
| Andrey |
| Anna |
| ... |
| cheese pizza |
| cheese pizza |
| ... |

## Exercise 02

- Программа расположена в директории: ex02;
- Файл для сдачи: `day01_ex02.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- SQL синтаксические конструкции: `DISTINCT`, `GROUP BY`, `HAVING`, любые типы `JOINs`.

Написан оператор SQL, который возвращает уникальные названия пиццы из таблицы «меню» и упорядочивает их по столбцу «`pizza_name`» в убывающем порядке. Не использованы конструкции из раздела «Недопустимо».

## Exercise 03

- Программа расположена в директории: ex03;
- Файл для сдачи: `day01_ex03.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- SQL синтаксические конструкции: любые типы `JOINs`.

Написан оператор SQL, который возвращает общие строки для атрибутов order_date, person_id из таблицы `person_order` с одной стороны и visit_date, person_id из таблицы `person_visits` с другой стороны (см. пример ниже).

Другими словами, найдены идентификаторы людей, которые в тот же день зашли и заказали пиццу. Добавлено упорядочение по столбцу action_date в возрастающем порядке, а затем по person_id в нисходящем порядке.

| action_date | person_id |
| ------ | ------ |
| 2022-01-01 | 6 |
| 2022-01-01 | 2 |
| 2022-01-01 | 1 |
| 2022-01-03 | 7 |
| 2022-01-04 | 3 |
| ... | ... |

## Exercise 04

- Программа расположена в директории: ex04;
- Файл для сдачи: `day01_ex04.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- SQL синтаксические конструкции: любые типы `JOINs`.

Написан оператор SQL, который возвращает разницу (минус) значений столбца person_id с сохранением дубликатов между таблицей `person_order` и таблицей `person_visits` для order_date и visit_date, относящихся к 7 января 2022 года.

## Exercise 05

- Программа расположена в директории: ex05;
- Файл для сдачи: `day01_ex05.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает все возможные комбинации между таблицами «`person`» и «`pizzeria`», и установлен порядок по идентификатору человека, а затем по столбцам идентификатора пиццерии.

Образец результата ниже:

| person.id | person.name | age | gender | address | pizzeria.id | pizzeria.name | rating |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| 1 | Anna | 16 | female | Moscow | 1 | Pizza Hut | 4.6 |
| 1 | Anna | 16 | female | Moscow | 2 | Dominos | 4.3 |
| ... | ... | ... | ... | ... | ... | ... | ... |

## Exercise 06

- Программа расположена в директории: ex06;
- Файл для сдачи: `day01_ex06.sql`;
- Языки: ANSI SQL.

Изменен оператор SQL из упражнения № 03, чтобы он возвращал имена людей вместо идентификаторов людей, и изменен порядок по action_date в возрастающем режиме, а затем по person_name в нисходящем режиме.

Образец результата:

| action_date | person_name |
| ------ | ------ |
| 2022-01-01 | Irina |
| 2022-01-01 | Anna |
| 2022-01-01 | Andrey |
| ... | ... |

## Exercise 07

- Программа расположена в директории: ex07;
- Файл для сдачи: `day01_ex07.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает дату заказа из таблицы «`person_order`» и соответствующее имя человека (имя и возраст форматируются, как в примере данных ниже), который сделал заказ из таблицы «`person`». Добавлена сортировка по обоим столбцам в порядке возрастания.

| order_date | person_information |
| ------ | ------ |
| 2022-01-01 | Andrey (age:21) |
| 2022-01-01 | Andrey (age:21) |
| 2022-01-01 | Anna (age:16) |
| ... | ... |

## Exercise 08

- Программа расположена в директории: ex08;
- Файл для сдачи: `day01_ex08.sql`;
- Языки: ANSI SQL;
- SQL синтаксические конструкции: `NATURAL JOIN`.

**Недопустимо**
- SQL синтаксические конструкции: любые типы `JOINs`.

Переписан оператор SQL из упражнения № 07, используя конструкцию NATURAL JOIN. Результат должен быть таким же, как в упражнении №07.

## Exercise 09

- Программа расположена в директории: ex09;
- Файл для сдачи: `day01_ex09.sql`;
- Языки: ANSI SQL.

Написаны 2 оператора SQL, которые возвращают список названий пиццерий, которые не посещались людьми, используя IN для 1-го и EXISTS для 2-го.

## Exercise 10

- Программа расположена в директории: ex10;
- Файл для сдачи: `day01_ex10.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает список имен людей, сделавших заказ на пиццу в соответствующей пиццерии. Пример результата (с именованными столбцами) представлен ниже, и 3 столбца упорядочены в порядке возрастания.

| person_name | pizza_name | pizzeria_name | 
| ------ | ------ | ------ |
| Andrey | cheese pizza | Dominos |
| Andrey | mushroom pizza | Dominos |
| Anna | cheese pizza | Pizza Hut |
| ... | ... | ... |
