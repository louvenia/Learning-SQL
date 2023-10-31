with uwv
         as (select coalesce(u.name, 'not defined')     name,
                    coalesce(u.lastname, 'not defined') lastname,
                    b.type                              type,
                    b.currency_id,
                    sum(b.money)                        volume
             from "user" u
                      full join balance b on u.id = b.user_id
             group by 1, 2, 3, 4),
     c_name
         as (select u.name,
                    u.lastname,
                    u.type,
                    u.currency_id,
                    u.volume,
                    coalesce(c.name, 'not defined') currency_name
             from uwv u
                      left join currency c on c.id = u.currency_id
             group by 1, 2, 3, 4, 5, 6),
     l_rate
         as (select c.id, name, rate_to_usd, l_date
             from (select id, max(updated) AS l_date
                   from currency c
                   group by 1) rate_date
                      left join currency c on rate_date.id = c.id and rate_date.l_date = c.updated),
     result as (select c_name.name                            name,
                       lastname                               lastname,
                       type,
                       volume,
                       currency_name,
                       coalesce(rate_to_usd, 1)               last_rate_to_usd,
                       coalesce(volume * rate_to_usd, volume) total_volume_in_usd
                from c_name
                         left join l_rate on l_rate.id = c_name.currency_id)
select *
from result
order by 1 desc, 2, 3;