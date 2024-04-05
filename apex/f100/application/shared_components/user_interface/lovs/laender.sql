prompt --application/shared_components/user_interface/lovs/laender
begin
--   Manifest
--     LAENDER
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
 p_id=>wwv_flow_imp.id(119353365495879591)
,p_lov_name=>'LAENDER'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'LAENDER'
,p_return_column_name=>'LAND_ID'
,p_display_column_name=>'BEZEICHNUNG'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'BEZEICHNUNG'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
