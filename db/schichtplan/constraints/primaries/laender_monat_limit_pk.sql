-- exported with dbms_metadata.get_ddl
alter table land_monat_limit add constraint laender_monat_limit_pk primary key (land_monat_limit_id)
  using index  enable;