select name, count(*) count_of_visits
from person_visits pv
         join person p on p.id = pv.person_id
group by name
order by count_of_visits desc, name
limit 4;