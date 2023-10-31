INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES(generate_series((SELECT MAX(id) + 1 FROM person_order), (SELECT MAX(id) + (SELECT COUNT(id) FROM person) FROM person_order), 1),
       generate_series((SELECT MIN(id) FROM person), (SELECT MAX(id) FROM person), 1),
       (SELECT id FROM menu WHERE pizza_name = 'greek pizza'), '2022-02-25');