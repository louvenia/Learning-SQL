with o as (select pz.name, count(*) count, 'order' action_type
           from person_order po
                    join menu m on m.id = po.menu_id
                    join pizzeria pz on pz.id = m.pizzeria_id
           group by pz.name
           order by count desc),
     v as (select pz.name, count(*) count, 'visit' action_type
           from person_visits pv
                    join pizzeria pz on pz.id = pv.pizzeria_id
           group by pz.name
           order by count desc),
     o_v as (select *
             from o
             union
             select *
             from v)
select name, sum(count) total_count
from o_v
group by name
order by total_count desc, name;