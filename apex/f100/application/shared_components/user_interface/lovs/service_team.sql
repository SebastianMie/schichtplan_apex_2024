prompt --application/shared_components/user_interface/lovs/service_team
begin
--   Manifest
--     SERVICE_TEAM
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(98357458882947261)
,p_lov_name=>'SERVICE_TEAM'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'SERVICE_TEAM'
,p_return_column_name=>'SERVICE_TEAM_ID'
,p_display_column_name=>'BEEZEICHNUNG'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'BEEZEICHNUNG'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
