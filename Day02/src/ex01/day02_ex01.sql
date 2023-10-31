SELECT missing_date::date
FROM generate_series('2022-01-01', '2022-01-10', INTERVAL '1 day') AS missing_date
LEFT JOIN
    (SELECT person_id, visit_date
     FROM person_visits
     WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND (person_id = 1 or person_id = 2)) AS pv
    ON missing_date = pv.visit_date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;