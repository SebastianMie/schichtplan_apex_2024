-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_monat_planung add constraint mitarbeiter_monat_planung_mitarbeiter_monat_planung_id_pk primary key (mitarbeiter_monat_planung_id)
  using index  enable;