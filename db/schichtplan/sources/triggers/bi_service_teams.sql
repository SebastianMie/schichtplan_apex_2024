create or replace editionable trigger bi_service_teams 
  before insert on service_teams               
  for each row  
begin   
  if :new.service_team_id is null then 
    select service_teams_seq.nextval into :new.service_team_id from sys.dual; 
  end if; 
end;
/
alter trigger bi_service_teams enable;