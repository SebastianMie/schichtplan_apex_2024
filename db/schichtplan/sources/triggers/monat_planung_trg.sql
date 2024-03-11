CREATE OR REPLACE EDITIONABLE TRIGGER monat_planung_trg 
   before insert on "SCHICHTPLANUNG"."MONAT_PLANUNG" 
   for each row 
begin  
   if inserting then 
      if :NEW."MONAT_PLANUNG_ID" is null then 
         select MONAT_PLANUNG_SEQ.nextval into :NEW."MONAT_PLANUNG_ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER monat_planung_trg ENABLE;