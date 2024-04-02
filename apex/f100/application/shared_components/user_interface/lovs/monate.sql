prompt --application/shared_components/user_interface/lovs/monate
begin
--   Manifest
--     MONATE
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
 p_id=>wwv_flow_imp.id(130853721866185480)
,p_lov_name=>'MONATE'
,p_lov_query=>'.'||wwv_flow_imp.id(130853721866185480)||'.'
,p_location=>'STATIC'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130853443542185474)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Dez 2022'
,p_lov_return_value=>'01.12.2022'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130853050673185471)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Jan 2023'
,p_lov_return_value=>'01.01.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130852611060185471)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Feb 2023'
,p_lov_return_value=>'01.02.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130852291524185470)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>unistr('M\00E4r 2023')
,p_lov_return_value=>'01.03.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130851900315185470)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'Apr 2023'
,p_lov_return_value=>'01.04.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130851447303185470)
,p_lov_disp_sequence=>6
,p_lov_disp_value=>'Mai 2023'
,p_lov_return_value=>'01.05.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130851050064185470)
,p_lov_disp_sequence=>7
,p_lov_disp_value=>'Jun 2023'
,p_lov_return_value=>'01.06.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130850695773185470)
,p_lov_disp_sequence=>8
,p_lov_disp_value=>'Jul 2023'
,p_lov_return_value=>'01.07.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130850209826185470)
,p_lov_disp_sequence=>9
,p_lov_disp_value=>'Aug 2023'
,p_lov_return_value=>'01.08.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130849827384185469)
,p_lov_disp_sequence=>10
,p_lov_disp_value=>'Sep 2023'
,p_lov_return_value=>'01.09.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130849443887185469)
,p_lov_disp_sequence=>11
,p_lov_disp_value=>'Okt 2023'
,p_lov_return_value=>'01.10.2023'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(130849100340185469)
,p_lov_disp_sequence=>12
,p_lov_disp_value=>'Nov 2023'
,p_lov_return_value=>'01.11.2023'
);
wwv_flow_imp.component_end;
end;
/
