-- exported with dbms_metadata.get_ddl
alter table laender_monat_limit add constraint laender_monat_limit_monat_planung_id foreign key (monat_planung_id)
	  references monat_planung (monat_planung_id) enable;