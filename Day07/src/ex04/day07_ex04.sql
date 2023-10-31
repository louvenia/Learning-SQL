select name, count(*) count_of_visits
from person p
         join person_visits pv on pv.person_id = p.id
group by name
having count(*) > 3;