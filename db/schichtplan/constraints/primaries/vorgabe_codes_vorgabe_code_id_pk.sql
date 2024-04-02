-- exported with dbms_metadata.get_ddl
alter table vorgabe_codes add constraint vorgabe_codes_vorgabe_code_id_pk primary key (vorgabe_code_id)
  using index enable;