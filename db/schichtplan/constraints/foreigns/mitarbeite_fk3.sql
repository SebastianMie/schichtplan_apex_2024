-- exported with dbms_metadata.get_ddl
alter table mitarbeiter add constraint mitarbeite_fk3 foreign key (land_id)
	  references land (land_id) enable;