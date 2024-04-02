-- exported with dbms_metadata.get_ddl
alter table laender add constraint laender_land_id_pk primary key (land_id)
  using index  enable;