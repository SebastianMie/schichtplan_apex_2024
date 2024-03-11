CREATE OR REPLACE EDITIONABLE TRIGGER bi_service_teams 
  before insert on "SERVICE_TEAM"               
  for each row  
begin   
  if :NEW."SERVICE_TEAM_ID" is null then 
    select "SERVICE_TEAMS_SEQ".nextval into :NEW."SERVICE_TEAM_ID" from sys.dual; 
  end if; 
end;
/
ALTER TRIGGER bi_service_teams ENABLE;