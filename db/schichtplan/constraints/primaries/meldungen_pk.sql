-- exported with dbms_metadata.get_ddl
alter table meldungen add constraint meldungen_pk primary key (meldung_id)
  using index  enable;