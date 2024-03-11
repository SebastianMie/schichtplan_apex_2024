-- exported with dbms_metadata.get_ddl
alter table land add constraint ref_land_pk primary key (land_id)
  using index  enable;