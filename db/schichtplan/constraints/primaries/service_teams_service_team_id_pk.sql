-- exported with dbms_metadata.get_ddl
alter table service_teams add constraint service_teams_service_team_id_pk primary key (service_team_id)
  using index enable;