-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_monat_planung add constraint mitarbeiter_id_fk foreign key (mitarbeiter_id)
	  references mitarbeiter (mitarbeiter_id) enable;