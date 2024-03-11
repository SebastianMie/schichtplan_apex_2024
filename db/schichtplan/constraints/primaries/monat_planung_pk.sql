-- exported with dbms_metadata.get_ddl
alter table monat_planung add constraint monat_planung_pk primary key (monat_planung_id)
  using index  enable;