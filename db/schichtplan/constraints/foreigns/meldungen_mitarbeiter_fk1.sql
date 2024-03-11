-- exported with dbms_metadata.get_ddl
alter table meldungen_mitarbeiter add constraint meldungen_mitarbeiter_fk1 foreign key (meldung_id)
	  references meldungen (meldung_id) enable;