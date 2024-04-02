-- exported with dbms_metadata.get_ddl
alter table planung_schichten add constraint planung_schichten_planung_schichten_id_pk primary key (planung_schichten_id)
  using index  enable;