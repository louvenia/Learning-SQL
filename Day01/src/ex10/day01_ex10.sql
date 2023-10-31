SELECT DISTINCT p.name AS person_name, m.pizza_name AS pizza_name, piz.name AS pizzeria_name
FROM pizzeria AS piz
JOIN menu AS m ON m.pizzeria_id = piz.id
JOIN person_order AS po ON po.menu_id = m.id
JOIN person AS p ON p.id = po.person_id
ORDER BY person_name, pizza_name, pizzeria_name;