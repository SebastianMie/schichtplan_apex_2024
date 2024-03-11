-- exported with dbms_metadata.get_ddl
alter table monat_planung add constraint ref_status_id_fk foreign key (ref_status_id)
	  references ref_status (ref_status_id) enable;