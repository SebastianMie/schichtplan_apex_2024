CREATE OR REPLACE EDITIONABLE TRIGGER land_monat_limit_pk_trg 
   before insert on "SCHICHTPLANUNG"."LAND_MONAT_LIMIT" 
   for each row 
begin  
   if inserting then 
      if :NEW."LAND_MONAT_LIMIT_ID" is null then 
         select LAND_MONAT_LIMIT_SEQ.nextval into :NEW."LAND_MONAT_LIMIT_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER land_monat_limit_pk_trg ENABLE;