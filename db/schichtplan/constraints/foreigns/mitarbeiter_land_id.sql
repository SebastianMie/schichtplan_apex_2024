-- exported with dbms_metadata.get_ddl
alter table mitarbeiter add constraint mitarbeiter_land_id foreign key (land_id)
	  references laender (land_id) enable;