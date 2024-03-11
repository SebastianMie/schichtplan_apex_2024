-- exported with dbms_metadata.get_ddl
alter table kommentar add constraint kommentar_pk1 primary key (kommentar_id)
  using index  enable;