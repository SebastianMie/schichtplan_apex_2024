-- exported with dbms_metadata.get_ddl
alter table land_monat_limit add constraint land_id_fk foreign key (land_id)
	  references land (land_id) enable;