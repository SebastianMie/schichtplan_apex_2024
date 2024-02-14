set define '^'
set concat on
set concat .
set verify off

@../../env.sql

-------------------------------------------------------------------------------------

PROMPT  =============================================================================
PROMPT  ==   CREATE WORKSPACE schichtplan_apex_2024
PROMPT  =============================================================================
PROMPT

declare
  v_workspace_id number;
begin
  select to_char(workspace_id)
    into v_workspace_id
    from apex_workspaces
   where workspace = upper('schichtplan_apex_2024');

  dbms_output.put_line('Workspace schichtplan_apex_2024 allready installed!');

  apex_instance_admin.remove_workspace(p_workspace         => upper('schichtplan_apex_2024'));

  raise no_data_found;
exception
  when no_data_found then
  -- workspace does not exist, so add it
    apex_instance_admin.add_workspace (p_workspace      => upper('schichtplan_apex_2024'),
                                       p_primary_schema => upper('schichtplan_apex_2024'));

    commit;
end;
/