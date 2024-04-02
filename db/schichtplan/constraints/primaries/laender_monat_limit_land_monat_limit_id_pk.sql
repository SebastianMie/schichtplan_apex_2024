-- exported with dbms_metadata.get_ddl
alter table laender_monat_limit add constraint laender_monat_limit_land_monat_limit_id_pk primary key (land_monat_limit_id)
  using index  enable;