create or replace editionable trigger bi_mitarbeiter 
  before insert on mitarbeiter               
  for each row  
begin   
  if :new.mitarbeiter_id is null then 
    select mitarbeiter_seq.nextval into :new.mitarbeiter_id from sys.dual; 
  end if; 
end; 
/
alter trigger bi_mitarbeiter enable;