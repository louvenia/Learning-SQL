comment on table person_discounts is 'This table describes the personal discounts of each client';
comment on column person_discounts.id is 'Primary key of this table';
comment on column person_discounts.person_id is 'Foreign key for persons linking the person_discounts table with the Primary key of the person table';
comment on column person_discounts.pizzeria_id is 'Foreign key for pizzerias linking the person_discounts table with the Primary key of the pizzeria table';
comment on column person_discounts.discount is 'Amount of personal discount';