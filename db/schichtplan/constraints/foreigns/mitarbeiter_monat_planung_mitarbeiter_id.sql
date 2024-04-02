-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_monat_planung add constraint mitarbeiter_monat_planung_mitarbeiter_id foreign key (mitarbeiter_id)
	  references mitarbeiter (mitarbeiter_id) enable;