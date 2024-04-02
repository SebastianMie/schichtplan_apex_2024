prompt --application/shared_components/user_interface/lovs/y_n
begin
--   Manifest
--     Y/N
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
 p_id=>wwv_flow_imp.id(127133390291583398)
,p_lov_name=>'Y/N'
,p_lov_query=>'.'||wwv_flow_imp.id(127133390291583398)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(127133031524583396)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Ja'
,p_lov_return_value=>'Y'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(127132613196583394)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Nein'
,p_lov_return_value=>'N'
);
wwv_flow_imp.component_end;
end;
/
