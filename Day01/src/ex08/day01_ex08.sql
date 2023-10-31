SELECT order_date, (p.name || ' (age:' || p.age || ')') AS person_information
FROM person_order
NATURAL JOIN (SELECT id AS person_id, name, age FROM person) AS p
ORDER BY order_date, person_information;