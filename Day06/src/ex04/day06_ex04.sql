alter table person_discounts
    add constraint ch_nn_person_id CHECK (person_id is not null),
    add constraint ch_nn_pizzeria_id CHECK (pizzeria_id is not null),
    add constraint ch_nn_discount CHECK (discount is not null),
    alter column discount set default 0,
    add constraint ch_range_discount CHECK (discount between 0 and 100);