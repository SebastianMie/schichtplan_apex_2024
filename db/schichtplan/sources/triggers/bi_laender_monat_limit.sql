create or replace editionable trigger bi_laender_monat_limit 
   before insert on laender_monat_limit
   for each row 
begin  
   if inserting then 
      if :new.land_monat_limit_id is null then 
         select laender_monat_limit_seq.nextval into :new.land_monat_limit_id from dual; 
      end if; 
   end if; 
end;
/
alter trigger bi_laender_monat_limit enable;