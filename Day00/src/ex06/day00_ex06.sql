SELECT
    (SELECT name FROM person AS p WHERE p.id = po.person_id) AS name,
    (SELECT name = 'Denis' FROM person AS p WHERE p.id = po.person_id) AS check_name
FROM person_order AS po
WHERE (po.menu_id = 13 or po.menu_id = 14 or po.menu_id = 18) AND po.order_date = '2022-01-07';