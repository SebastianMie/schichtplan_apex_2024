-- exported with dbms_metadata.get_ddl
alter table rollen add constraint rollen_rolle_id_pk primary key (rolle_id)
  using index  enable;