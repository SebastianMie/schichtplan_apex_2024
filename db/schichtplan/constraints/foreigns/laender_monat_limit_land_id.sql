-- exported with dbms_metadata.get_ddl
alter table laender_monat_limit add constraint laender_monat_limit_land_id foreign key (land_id)
	  references laender (land_id) enable;