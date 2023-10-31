SELECT DISTINCT person_id
FROM person_visits
WHERE visit_date IN ('2022-01-06', '2022-01-07', '2022-01-08', '2022-01-09') OR pizzeria_id = 2
ORDER BY person_id DESC;