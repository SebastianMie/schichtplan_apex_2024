-- exported with dbms_metadata.get_ddl
alter table status add constraint status_status_id_pk primary key (status_id)
  using index  enable;