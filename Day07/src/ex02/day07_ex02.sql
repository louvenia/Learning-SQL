with o as (select pz.name, count(*) count, 'order' action_type
           from person_order po
                    join menu m on m.id = po.menu_id
                    join pizzeria pz on pz.id = m.pizzeria_id
           group by pz.name
           order by count desc
           limit 3),
     v as (select pz.name, count(*) count, 'visit' action_type
           from person_visits pv
                    join pizzeria pz on pz.id = pv.pizzeria_id
           group by pz.name
           order by count desc
           limit 3)
select *
from o
union
select *
from v
order by action_type, count desc;