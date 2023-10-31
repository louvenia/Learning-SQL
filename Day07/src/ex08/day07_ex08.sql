select address, pz.name, count(*) count_of_orders
from person p
         join person_order po on po.person_id = p.id
         join menu m on m.id = po.menu_id
         join pizzeria pz on pz.id = m.pizzeria_id
group by 1, 2
order by 1, 2;