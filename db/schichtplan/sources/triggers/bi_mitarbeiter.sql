CREATE OR REPLACE EDITIONABLE TRIGGER bi_mitarbeiter 
  before insert on "MITARBEITER"               
  for each row  
begin   
  if :NEW."MITARBEITER_ID" is null then 
    select "MITARBEITER_SEQ".nextval into :NEW."MITARBEITER_ID" from sys.dual; 
  end if; 
end; 
/
ALTER TRIGGER bi_mitarbeiter ENABLE;