create or replace editionable trigger bi_monat_planung 
   before insert on monat_planung 
   for each row 
begin  
   if inserting then 
      if :new.monat_planung_id is null then 
         select monat_planung_seq.nextval into :new.monat_planung_id from dual; 
      end if; 
   end if; 
end;
/
alter trigger bi_monat_planung enable;