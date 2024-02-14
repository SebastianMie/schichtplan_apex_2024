set define '^'
set verify off

@../env.sql

prompt
prompt
prompt **********************************************************************
prompt ***  USER CREATION: ^db_app_user
prompt **********************************************************************
prompt
prompt

prompt ^db_app_user droppen
declare
  v_check number(1) := 0;
begin
  select 1
    into v_check
    from all_users
   where username = upper('^db_app_user');
  dbms_output.put_line('drop user ^db_app_user cascade');
  execute immediate 'drop user ^db_app_user cascade';
exception
  when no_data_found then
    null; -- ok, nothing to drop  ´
end;
/

prompt create user ^db_app_user identified by "^db_app_pwd" default tablespace ^deftablespace
create user ^db_app_user
  identified by "^db_app_pwd"
  default tablespace ^deftablespace
  temporary tablespace temp
  profile default
  account unlock;


-- 2 roles for ^db_app_user
grant connect to ^db_app_user;
alter user ^db_app_user default role all;
grant create any context to ^db_app_user;

prompt **********************************************************************
prompt
prompt-- 2 tablespace quotas for schichtplan
alter user schichtplan quota unlimited on ^deftablespace;


-- 11 system privileges for schichtplan
grant create any context to schichtplan;
grant create any directory to schichtplan;
grant create any procedure to schichtplan;
grant create job to schichtplan;
grant create procedure to schichtplan;
grant create sequence to schichtplan;
grant create synonym to schichtplan;
grant create public synonym to schichtplan;
grant create table to schichtplan;
grant create trigger to schichtplan;
grant create type to schichtplan;
grant create view to schichtplan;
grant create session to schichtplan;

-- 5 object privileges for schichtplan
grant execute on sys.dbms_crypto to schichtplan;
grant execute on sys.utl_file to schichtplan;
grant execute on sys.utl_http to schichtplan;
grant execute on sys.dbms_rls to schichtplan;


prompt **********************************************************************
prompt
prompt