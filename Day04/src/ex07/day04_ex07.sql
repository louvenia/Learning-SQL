insert into person_visits (id, person_id, pizzeria_id, visit_date)
values ((select max(id) + 1 from person_visits),
        (select id from person where name = 'Dmitriy'),
        (select id from pizzeria where name = 'DoDo Pizza'),
        '2022-01-08');

refresh materialized view mv_dmitriy_visits_and_eats;