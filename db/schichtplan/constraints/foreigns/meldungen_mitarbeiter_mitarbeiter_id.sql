-- exported with dbms_metadata.get_ddl
alter table meldungen_mitarbeiter add constraint meldungen_mitarbeiter_mitarbeiter_id foreign key (mitarbeiter_id)
	  references mitarbeiter (mitarbeiter_id) enable;