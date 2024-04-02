prompt --application/shared_components/logic/application_processes/get_url_modal_rb
begin
--   Manifest
--     APPLICATION PROCESS: get_url_modal_rb
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(116261549018588794)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_url_modal_rb'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_url VARCHAR2(3000);',
'    l_app NUMBER := v(''APP_ID'');',
'    l_session NUMBER := v(''APP_SESSION'');',
'    p_datum VARCHAR2(200);',
'BEGIN',
'   p_datum := apex_application.g_x01;',
'',
'    l_url := APEX_UTIL.PREPARE_URL(',
'        p_url => ''f?p='' || l_app || '':29:'' || l_session || ''::::P29_DATUM:'' || p_datum,',
'        p_checksum_type => ''SESSION'');',
'',
'    apex_json.open_object;',
'    apex_json.write(''dialog_url'', l_url);',
'    apex_json.close_object;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
