-- exported with dbms_metadata.get_ddl
alter table ref_feiertag add constraint feiertag_pk1 primary key (feiertag_id)
  using index  enable;