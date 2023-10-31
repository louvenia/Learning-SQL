select pz.name,
       count(menu_id)       count_of_orders,
       round(avg(price), 2) average_price,
       max(price)           max_price,
       min(price)           min_price
from menu m
         join person_order po on po.menu_id = m.id
         join pizzeria pz on pz.id = m.pizzeria_id
group by 1
order by 1;