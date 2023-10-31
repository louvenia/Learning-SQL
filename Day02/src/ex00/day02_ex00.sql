SELECT name AS pizzeria_name, rating
FROM pizzeria
LEFT JOIN person_visits ON pizzeria_id = pizzeria.id
WHERE person_visits IS NULL;