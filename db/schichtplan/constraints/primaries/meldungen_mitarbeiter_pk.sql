-- exported with dbms_metadata.get_ddl
alter table meldungen_mitarbeiter add constraint meldungen_mitarbeiter_pk primary key (meldungen_mitarbeiter_id)
  using index  enable;