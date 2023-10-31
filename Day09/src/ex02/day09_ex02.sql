create or replace function fnc_trg_person_delete_audit() returns trigger as
$person_delete_audit$
begin
    insert into person_audit (type_event, row_id, name, age, gender, address)
    select 'D', old.*;
    return null;
end;
$person_delete_audit$ language plpgsql;

create trigger trg_person_delete_audit
    after delete
    on person
    for each row
execute function fnc_trg_person_delete_audit();

DELETE
FROM person
WHERE id = 10;