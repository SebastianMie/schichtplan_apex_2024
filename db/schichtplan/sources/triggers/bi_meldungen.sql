CREATE OR REPLACE EDITIONABLE TRIGGER bi_meldungen 
  before insert on "MELDUNGEN"               
  for each row  
begin   
  if :NEW."MELDUNG_ID" is null then 
    select "MELDUNGEN_SEQ".nextval into :NEW."MELDUNG_ID" from sys.dual; 
  end if; 
end; 
/
ALTER TRIGGER bi_meldungen ENABLE;