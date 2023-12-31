# Day 07

## Агрегированные данные более информативны

Использование определенных конструкции OLAP для получения «значения» из данных.

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

## Rules of the day

- Убедитесь, что у вас есть собственная база данных и доступ к ней PostgreSQL.
- Загрузите [скрипт](materials/model.sql) с моделью базы данных здесь и примените его к своей базе данных. **Все изменения, которые были внесены в День 03 в упражнениях 07–13 и День 04 в упражнении 07, должны быть на месте (это похоже на то, как в реальном мире, когда применяется выпуск, и необходимо обеспечить согласованность с данными для новых изменений).**
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
- Файл для сдачи: `day07_ex00.sql`;
- Языки: ANSI SQL.

Было проведено простое агрегирование: написан оператор SQL, который возвращает идентификаторы людей и соответствующее количество посещений в любых пиццериях, а также сортировку по количеству посещений в режиме убывания и сортировку по `person_id` в режиме возрастания. Образец данных результата представлен ниже.

| person_id | count_of_visits |
| ------ | ------ |
| 9 | 4 |
| 4 | 3 |
| ... | ... | 

## Exercise 01

- Программа расположена в директории: ex01;
- Файл для сдачи: `day07_ex01.sql`;
- Языки: ANSI SQL.

Изменен оператор SQL из упражнения 00 и возвращается имя человека (не идентификатор). Дополнительный пункт - нам нужно видеть только топ-4 персон с максимальным количеством посещений в любых пиццериях и отсортированных по имени человека. Пример выходных данных ниже.

| name | count_of_visits |
| ------ | ------ |
| Dmitriy | 4 |
| Denis | 3 |
| ... | ... | 

## Exercise 02

- Программа расположена в директории: ex02;
- Файл для сдачи: `day07_ex02.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, чтобы видеть 3 любимых ресторана по посещениям и заказам в одном списке (добавлен столбец action_type со значениями «заказ» или «посещение», это зависит от данных из соответствующей таблицы). Результат отсортирован по столбцу action_type в возрастающем режиме и по столбцу count в нисходящем режиме.

Пример выходных данных представлен ниже. 

| name | count | action_type |
| ------ | ------ | ------ |
| Dominos | 6 | order |
| ... | ... | ... |
| Dominos | 7 | visit |
| ... | ... | ... |

## Exercise 03

- Программа расположена в директории: ex03;
- Файл для сдачи: `day07_ex03.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, чтобы увидеть, как рестораны группируются по посещениям и заказам и объединяются друг с другом по названию ресторана.
Были использованы внутренние SQL-запросы из упражнения 02 (рестораны по посещениям и по заказам) без ограничений количества строк.

Кроме того, были добавлены следующие правила:
- подсчитаны суммы заказов и посещений соответствующей пиццерии (обратите внимание, в обеих таблицах представлены не все ключи от пиццерий).
- отсортированы результаты по столбцу `total_count` в порядке убывания и по `name` в порядке возрастания.
Взгляните на образец данных ниже.

| name | total_count |
| ------ | ------ |
| Dominos | 13 |
| DinoPizza | 9 |
| ... | ... | 

## Exercise 04

- Программа расположена в директории: ex04;
- Файл для сдачи: `day07_ex04.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- Синтаксическая конструкция: `WHERE`.

Написан оператор SQL, который возвращает имя человека и соответствующее количество посещений любой пиццерии, если человек посещал ее более 3 раз (> 3). Взгляните на образец данных ниже.

| name | count_of_visits |
| ------ | ------ |
| Dmitriy | 4 |

## Exercise 05

- Программа расположена в директории: ex05;
- Файл для сдачи: `day07_ex05.sql`;
- Языки: ANSI SQL.

**Недопустимо**
- Синтаксическая конструкция: `GROUP BY`, любые типы (`UNION`,...) работа с наборами.

Написан простой SQL-запрос, который возвращает список уникальных имен людей, делавших заказы в любых пиццериях. Результат отсортирован по имени человека.

Образец выходных данных представлен ниже:

| name | 
| ------ |
| Andrey |
| Anna | 
| ... | 

## Exercise 06

- Программа расположена в директории: ex06;
- Файл для сдачи: `day07_ex06.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает количество заказов, среднюю цену, максимальную и минимальную цены на проданную пиццу соответствующей пиццерией. Результат отсортирован по названию пиццерии. Средняя цена округлена до двух плавающих чисел. Образец данных представлен ниже:

| name | count_of_orders | average_price | max_price | min_price |
| ------ | ------ | ------ | ------ | ------ |
| Best Pizza | 5 | 780 | 850 | 700 |
| DinoPizza | 5 | 880 | 1000 | 800 |
| ... | ... | ... | ... | ... |

## Exercise 07

- Программа расположена в директории: ex07;
- Файл для сдачи: `day07_ex07.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает общий средний рейтинг (имя выходного атрибута — global_rating) для всех ресторанов. Средний рейтинг округлен до 4 плавающих чисел.

## Exercise 08

- Программа расположена в директории: ex08;
- Файл для сдачи: `day07_ex08.sql`;
- Языки: ANSI SQL.

О личных адресах мы знаем из наших данных. Предположим, этот конкретный человек посещает пиццерии только в своем городе. 

Написан оператор SQL, который возвращает адрес, название пиццерии и количество заказов людей. Результат отсортирован по адресу, а затем по названию ресторана. Образец выходных данных ниже.

| address | name |count_of_orders |
| ------ | ------ |------ |
| Kazan | Best Pizza |4 |
| Kazan | DinoPizza |4 |
| ... | ... | ... | 

## Exercise 09

- Программа расположена в директории: ex09;
- Файл для сдачи: `day07_ex09.sql`;
- Языки: ANSI SQL.

Написан оператор SQL, который возвращает агрегированную информацию по адресу человека, результат «Максимальный возраст — (Минимальный возраст / Максимальный возраст)», который представлен в виде столбца формулы, следующий — средний возраст по адресу и результат сравнения между формулами. и средние столбцы (другими словами, если формула больше среднего, тогда значение True, в противном случае значение False).

Результат отсортирован по столбцу адреса. Образец выходных данных ниже.

| address | formula |average | comparison |
| ------ | ------ |------ |------ |
| Kazan | 44.71 |30.33 | true |
| Moscow | 20.24 | 18.5 | true |
| ... | ... | ... | ... |
