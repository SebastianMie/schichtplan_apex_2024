create or replace editionable trigger bi_planung_schichten 
  before insert on planung_schichten               
  for each row  
begin   
  if :new.planung_schichten_id is null then 
    select planung_schichten_seq.nextval into :new.planung_schichten_id from sys.dual; 
  end if; 
end; 
/
alter trigger bi_planung_schichten enable;