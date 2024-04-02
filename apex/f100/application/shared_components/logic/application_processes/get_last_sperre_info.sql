prompt --application/shared_components/logic/application_processes/get_last_sperre_info
begin
--   Manifest
--     APPLICATION PROCESS: get_last_sperre_info
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
 p_id=>wwv_flow_imp.id(96497129382374028)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_last_sperre_info'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  p_sperre_info VARCHAR2(100);',
'BEGIN',
unistr('  p_sperre_info := utility_pkg.get_last_sperre_info(:APP_USER); -- Annahme: utility_pkg.get_last_sperre_info() gibt die Sperrinfo zur\00FCck'),
'  ',
'  if p_sperre_info is not null then',
'    apex_json.open_object;',
'    apex_json.write(''success'', TRUE);',
'    apex_json.write(''sperre_info'', p_sperre_info);',
'    apex_json.close_object; ',
'  else',
'    apex_json.open_object;',
'    apex_json.write(''success'', FALSE);',
'    apex_json.write(''sperre_info'', '''');',
'    apex_json.close_object; ',
'  end if;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_when_type=>'NEVER'
);
wwv_flow_imp.component_end;
end;
/
