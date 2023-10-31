SELECT pizza_name, price, piz.name pizzeria_name, visit_date
FROM menu m
JOIN pizzeria piz ON piz.id = m.pizzeria_id
JOIN person_visits pv ON pv.pizzeria_id = piz.id
JOIN person p ON p.id = pv.person_id
WHERE p.name = 'Kate' AND price BETWEEN 800 AND 1000
ORDER BY 1, 2, 3;