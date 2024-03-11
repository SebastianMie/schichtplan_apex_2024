-- exported with dbms_metadata.get_ddl
create index idx_planung_schichten_datum on planung_schichten (trunc(datum)) 
  ;