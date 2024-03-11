-- exported with dbms_metadata.get_ddl
alter table planung_schichten add constraint planung_schichten_uq unique (datum, mitarbeiter_id)
  using index  enable;