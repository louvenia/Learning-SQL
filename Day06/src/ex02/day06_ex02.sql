with dp as (select p.name,
                   pizza_name,
                   price,
                   round(price - ((price * discount) / 100)) discount_price,
                   pz.name                                   pizzeria_name
            from person p
                     join person_order po on po.person_id = p.id
                     join menu m on m.id = po.menu_id
                     join pizzeria pz on pz.id = m.pizzeria_id
                     join person_discounts pd on (pd.person_id = p.id and pd.pizzeria_id = pz.id))
select *
from dp
order by 1, 2;