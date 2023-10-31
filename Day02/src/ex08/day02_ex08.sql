SELECT name
FROM person p
JOIN person_order po ON po.person_id = p.id
JOIN (SELECT id, pizza_name FROM menu WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza') m
    ON po.menu_id = m.id
WHERE gender = 'male' AND (address = 'Moscow' OR address = 'Samara')
ORDER BY name DESC;