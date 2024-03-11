-- exported with dbms_metadata.get_ddl
alter table ref_status add constraint ref_status_pk primary key (ref_status_id)
  using index  enable;