create or replace editionable trigger bi_meldungen 
  before insert on meldungen               
  for each row  
begin   
  if :new.meldung_id is null then 
    select meldungen_seq.nextval into :new.meldung_id from sys.dual; 
  end if; 
end; 
/
alter trigger bi_meldungen enable;