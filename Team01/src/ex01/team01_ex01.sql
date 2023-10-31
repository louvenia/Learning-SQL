-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

with usd as (select b.user_id     balance_user_id,
                    b.money,
                    b.updated,
                    c.name        c_name,
                    c.rate_to_usd c_rate,
                    c.updated     c_updated
             from balance b
                      join currency c on b.currency_id = c.id),
     past as (select usd.balance_user_id      id,
                     c_name,
                     money,
                     updated,
                     min(updated - c_updated) difference
              from usd
              where (updated - c_updated) > interval '0 days'
              group by 1, 2, 3, 4),
     future as (select usd.balance_user_id      id,
                       c_name,
                       money,
                       updated,
                       max(updated - c_updated) difference
                from usd
                where (updated - c_updated) < interval '0 days'
                group by 1, 2, 3, 4),
     joins as (select t2.id,
                      t2.c_name,
                      t2.money,
                      t2.updated,
                      coalesce(t1.difference, t2.difference) ndifference
               from past t1
                        full join future t2
                                  on t1.id = t2.id and
                                     t1.c_name = t2.c_name and
                                     t1.money = t2.money and t1.updated = t2.updated),
     result as (select coalesce(u.name, 'not defined')     name,
                       coalesce(u.lastname, 'not defined') lastname,
                       j.c_name                            currency_name,
                       j.money * c.rate_to_usd             currency_in_usd
                from joins j
                         left join "user" u on j.id = u.id
                         left join currency c on j.ndifference = (j.updated - c.updated) and
                                                 j.c_name = c.name)
select *
from result
order by 1 desc, 2, 3;