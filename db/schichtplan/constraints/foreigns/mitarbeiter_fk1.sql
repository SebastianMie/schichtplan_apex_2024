-- exported with dbms_metadata.get_ddl
alter table mitarbeiter add constraint mitarbeiter_fk1 foreign key (rolle_id)
	  references rolle (rolle_id) enable;