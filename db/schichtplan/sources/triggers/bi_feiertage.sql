create or replace editionable trigger bi_feiertage 
   before insert on feiertage
   for each row 
begin  
   if :new.feiertag_id is null then 
         select feiertage_seq.nextval into :new.feiertag_id from dual; 
   end if; 
end;
/
alter trigger bi_feiertage enable;