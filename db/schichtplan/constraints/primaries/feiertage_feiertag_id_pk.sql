-- exported with dbms_metadata.get_ddl
alter table feiertage add constraint feiertag_feiertag_id_pk primary key (feiertag_id)
  using index  enable;