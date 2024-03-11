-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_seite_sperre add constraint mitarbeiter_seite_sperre_pk primary key (mitarbeiter_seite_sperre_id)
  using index  enable;