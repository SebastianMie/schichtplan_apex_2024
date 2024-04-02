-- exported with dbms_metadata.get_ddl
alter table mitarbeiter add constraint mitarbeiter_rolle_id foreign key (rolle_id)
	  references rollen (rolle_id) enable;