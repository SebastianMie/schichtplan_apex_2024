-- exported with dbms_metadata.get_ddl
alter table meldungen_mitarbeiter add constraint meldungen_mitarbeiter_fk2 foreign key (mitarbeiter_id)
	  references mitarbeiter (mitarbeiter_id) enable;