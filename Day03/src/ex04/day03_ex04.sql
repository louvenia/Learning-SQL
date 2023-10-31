WITH f_m AS(
    SELECT gender, piz.name pizzeria_name
    FROM pizzeria piz
    JOIN menu m ON m.pizzeria_id = piz.id
    JOIN person_order po ON po.menu_id = m.id
    JOIN person p ON p.id = po.person_id
), f AS(
    SELECT pizzeria_name FROM f_m WHERE gender = 'female'
), m AS(
    SELECT pizzeria_name FROM f_m WHERE gender = 'male'
), only_f AS(
    SELECT * FROM f
    EXCEPT
    SELECT * FROM m
), only_m AS(
    SELECT * FROM m
    EXCEPT
    SELECT * FROM f
)
SELECT * FROM only_f
UNION
SELECT * FROM only_m
ORDER BY 1;
