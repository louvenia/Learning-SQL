WITH p AS(
    SELECT pizza_name, name, price
    FROM pizzeria
    JOIN menu m ON m.pizzeria_id = pizzeria.id
)
SELECT p1.pizza_name, p1.name pizzeria_name_1, p2.name pizzeria_name_2, p1.price
FROM p p1
JOIN (SELECT pizza_name, name, price FROM p) p2
ON p1.price = p2.price AND p1.pizza_name = p2.pizza_name AND p1.name > p2.name
ORDER BY 1;