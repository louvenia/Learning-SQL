with np as (select address, age::numeric n_age
            from person)
select address,
       round(max(n_age) - (min(n_age) / max(n_age)), 2)      formula,
       round(avg(n_age), 2)                                  average,
       (max(n_age) - (min(n_age) / max(n_age))) > avg(n_age) comparison
from np
group by 1
order by 1;