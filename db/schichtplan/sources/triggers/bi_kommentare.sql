create or replace editionable trigger bi_kommentare 
before insert on kommentare 
for each row
begin
    if :new.kommentar_id is null then
        select kommentare_seq.nextval
        into :new.kommentar_id
        from dual;
    end if;
end;
/
alter trigger bi_kommentare enable;