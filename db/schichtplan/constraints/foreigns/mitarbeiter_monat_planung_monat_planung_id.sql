-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_monat_planung add constraint mitarbeiter_monat_planung_monat_planung_id foreign key (monat_planung_id)
	  references monat_planung (monat_planung_id) enable;