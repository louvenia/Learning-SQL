create view v_symmetric_union as
with R as (select person_id
           from person_visits
           where visit_date = '2022-01-02'),
     S as (select person_id
           from person_visits
           where visit_date = '2022-01-06'),
     R_S as (select *
             from R
             except
             select *
             from S),
     S_R as (select *
             from S
             except
             select *
             from R)
select *
from R_S
union
select *
from S_R
order by 1;