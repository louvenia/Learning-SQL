WITH v AS(
    SELECT piz.name pizzeria_name
    FROM pizzeria piz
    JOIN person_visits pv ON pv.pizzeria_id = piz.id
    JOIN person p ON p.id = pv.person_id AND p.name = 'Andrey'
), o AS(
    SELECT piz.name pizzeria_name
    FROM pizzeria piz
    JOIN menu m ON m.pizzeria_id = piz.id
    JOIN person_order po ON po.menu_id = m.id
    JOIN person p ON p.id = po.person_id AND p.name = 'Andrey'
)
SELECT * FROM v
EXCEPT
SELECT * FROM o
ORDER BY 1;
