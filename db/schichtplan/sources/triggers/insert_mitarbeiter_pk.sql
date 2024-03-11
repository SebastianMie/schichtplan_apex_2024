CREATE OR REPLACE EDITIONABLE TRIGGER insert_mitarbeiter_pk 
   before insert on  "MITARBEITER" 
   for each row 
begin  
   if inserting then 
      if :NEW."MITARBEITER_ID" is null then 
         select MITARBEITER_SEQ.nextval into :NEW."MITARBEITER_ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER insert_mitarbeiter_pk ENABLE;