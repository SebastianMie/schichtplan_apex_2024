-- exported with dbms_metadata.get_ddl
alter table land_monat_limit add constraint monat_planung_id_fk1 foreign key (monat_planung_id)
	  references monat_planung (monat_planung_id) enable;