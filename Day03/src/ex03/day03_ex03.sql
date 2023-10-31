WITH f_m AS(
    SELECT gender, piz.name pizzeria_name
    FROM pizzeria piz
    JOIN person_visits pv ON pv.pizzeria_id = piz.id
    JOIN person p ON p.id = pv.person_id
), f AS(
    SELECT pizzeria_name FROM f_m WHERE gender = 'female'
), m AS(
    SELECT pizzeria_name FROM f_m WHERE gender = 'male'
), only_f AS(
    SELECT * FROM f
    EXCEPT ALL
    SELECT * FROM m
), only_m AS(
    SELECT * FROM m
    EXCEPT ALL
    SELECT * FROM f
)
SELECT * FROM only_f
UNION ALL
SELECT * FROM only_m
ORDER BY 1;
