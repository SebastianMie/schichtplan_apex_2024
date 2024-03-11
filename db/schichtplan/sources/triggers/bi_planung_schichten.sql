CREATE OR REPLACE EDITIONABLE TRIGGER bi_planung_schichten 
  before insert on "PLANUNG_SCHICHTEN"               
  for each row  
begin   
  if :NEW."PLANUNG_SCHICHTEN_ID" is null then 
    select "PLANUNG_SCHICHTEN_SEQ".nextval into :NEW."PLANUNG_SCHICHTEN_ID" from sys.dual; 
  end if; 
end; 
/
ALTER TRIGGER bi_planung_schichten ENABLE;