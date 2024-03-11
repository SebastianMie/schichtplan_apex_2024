CREATE OR REPLACE EDITIONABLE TRIGGER insert_ref_feiertag 
   before insert on "SCHICHTPLANUNG"."REF_FEIERTAG" 
   for each row 
begin  
   if :NEW."FEIERTAG_ID" is null then 
         select REF_FEIERTAG_SEQ.nextval into :NEW."FEIERTAG_ID" from dual; 
   end if; 
end;
/
ALTER TRIGGER insert_ref_feiertag ENABLE;