-- exported with dbms_metadata.get_ddl
create unique index planung_schichten_uq on planung_schichten (datum, mitarbeiter_id) 
  ;