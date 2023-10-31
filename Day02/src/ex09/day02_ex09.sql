WITH f_name AS (
    SELECT * FROM person p
    JOIN person_order po ON po.person_id = p.id
    JOIN menu m ON m.id = po.menu_id
    WHERE gender = 'female'
)
SELECT name FROM f_name WHERE pizza_name = 'cheese pizza'
INTERSECT
SELECT name FROM f_name WHERE pizza_name = 'pepperoni pizza'
ORDER BY name;