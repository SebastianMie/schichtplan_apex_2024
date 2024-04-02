prompt --application/shared_components/user_interface/lovs/vorgabe_codes_display
begin
--   Manifest
--     VORGABE_CODES_DISPLAY
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
 p_id=>wwv_flow_imp.id(98022396014775079)
,p_lov_name=>'VORGABE_CODES_DISPLAY'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_query_table=>'VORGABE_CODES'
,p_return_column_name=>'VORGABE_CODE_ID'
,p_display_column_name=>'VORGABE_CODE_ID'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'VORGABE_CODE_ID'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
