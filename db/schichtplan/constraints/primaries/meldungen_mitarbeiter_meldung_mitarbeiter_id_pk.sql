-- exported with dbms_metadata.get_ddl
alter table meldungen_mitarbeiter add constraint meldungen_mitarbeiter_meldung_mitarbeiter_id_pk primary key (meldung_mitarbeiter_id)
  using index  enable;