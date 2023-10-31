-- Session #1
begin;
-- Session #2
begin;
-- Session #1
set transaction isolation level serializable;
-- Session #2
set transaction isolation level serializable;
-- Session #1
select * from pizzeria where name = 'Pizza Hut';
-- Session #2
select * from pizzeria where name = 'Pizza Hut';
-- Session #2
update pizzeria set rating = 3.0 where name = 'Pizza Hut';
-- Session #2
commit;
-- Session #1
select * from pizzeria where name = 'Pizza Hut';
-- Session #1
commit;
-- Session #1
select * from pizzeria where name = 'Pizza Hut';
-- Session #2
select * from pizzeria where name = 'Pizza Hut';