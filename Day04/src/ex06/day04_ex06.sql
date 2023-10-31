create materialized view if not exists mv_dmitriy_visits_and_eats as
select pizzeria.name pizzeria_name
from pizzeria
         join person_visits pv on pv.pizzeria_id = pizzeria.id
         join person p on p.id = pv.person_id
         join menu m on m.pizzeria_id = pizzeria.id
where p.name = 'Dmitriy'
  and pv.visit_date = '2022-01-08'
  and m.price < 800;