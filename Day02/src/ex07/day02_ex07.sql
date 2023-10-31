SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits AS pv ON pv.pizzeria_id = pizzeria.id
JOIN person AS p ON p.id = pv.person_id
JOIN menu AS m ON m.pizzeria_id = pizzeria.id
WHERE p.name = 'Dmitriy'AND pv.visit_date = '2022-01-08' AND m.price < 800;