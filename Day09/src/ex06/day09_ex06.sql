create or replace function fnc_person_visits_and_eats_on_date(pperson varchar default 'Dmitriy',
                                                              pprice numeric default 500,
                                                              pdate date default '2022-01-08')
    returns table
            (
                name varchar
            )
as
$$
begin
    return query
        select pz.name
        from pizzeria pz
                 join person_visits pv on pv.pizzeria_id = pz.id
                 join menu m on m.pizzeria_id = pz.id
                 join person_order po on po.menu_id = m.id
                 join person p on p.id = pv.person_id and p.id = po.person_id
        where p.name = pperson
          and price < pprice
          and order_date = pdate
          and visit_date = pdate;
end;
$$ language plpgsql;