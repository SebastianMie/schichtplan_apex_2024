prompt --application/shared_components/user_interface/lovs/monat_jahr_archiv
begin
--   Manifest
--     MONAT_JAHR_ARCHIV
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
 p_id=>wwv_flow_imp.id(119153141521844429)
,p_lov_name=>'MONAT_JAHR_ARCHIV'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select monat_jahr d, monat_jahr r',
'from monat_planung',
'where ref_status_id = 4 --Nur archivierte monate anzeigen',
'order by TO_DATE(monat_jahr, ''MON YYYY'') desc',
''))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'R'
,p_display_column_name=>'D'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
);
wwv_flow_imp.component_end;
end;
/
