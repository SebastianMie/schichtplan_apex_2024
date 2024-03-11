-- exported with dbms_metadata.get_ddl
alter table mitarbeiter add constraint mitarbeiter_pk primary key (mitarbeiter_id)
  using index  enable;