-- exported with dbms_metadata.get_ddl
alter table rolle add constraint rolle_pk primary key (rolle_id)
  using index  enable;