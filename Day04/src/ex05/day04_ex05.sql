create view v_price_with_discount as
select name, pizza_name, price, round(price * 0.9) as discount_price
from menu m
         join person_order po on po.menu_id = m.id
         join person p on p.id = po.person_id
order by 1, 2;