WITH fm AS(
    SELECT m.id AS menu_id
    FROM menu m
    EXCEPT
    SELECT po.menu_id
    FROM person_order po
)
SELECT pizza_name, price, piz.name AS pizzeria_name
FROM fm
LEFT JOIN menu m ON m.id = fm.menu_id
LEFT JOIN pizzeria piz ON piz.id = m.pizzeria_id
ORDER BY 1,2;