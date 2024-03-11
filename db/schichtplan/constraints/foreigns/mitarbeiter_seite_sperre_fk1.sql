-- exported with dbms_metadata.get_ddl
alter table mitarbeiter_seite_sperre add constraint mitarbeiter_seite_sperre_fk1 foreign key (mitarbeiter_id)
	  references mitarbeiter (mitarbeiter_id) enable;