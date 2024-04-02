-- exported with dbms_metadata.get_ddl
alter table kommentare add constraint kommentare_kommentar_id_pk primary key (kommentar_id)
  using index  enable;