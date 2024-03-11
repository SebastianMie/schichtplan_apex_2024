-- exported with dbms_metadata.get_ddl
alter table service_team add constraint service_teams_pk primary key (service_team_id)
  using index  enable;