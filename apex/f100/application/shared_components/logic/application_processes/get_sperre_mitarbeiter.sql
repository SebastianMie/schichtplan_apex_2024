prompt --application/shared_components/logic/application_processes/get_sperre_mitarbeiter
begin
--   Manifest
--     APPLICATION PROCESS: get_sperre_mitarbeiter
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
 p_id=>wwv_flow_imp.id(96594638997625083)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_sperre_mitarbeiter'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   mitarbeiter_sperre varchar2(50);',
'',
'BEGIN',
'   mitarbeiter_sperre := '''';',
'   ',
'   mitarbeiter_sperre := utility_pkg.get_last_sperre_ma();',
'',
'   if mitarbeiter_sperre != '''' and mitarbeiter_sperre is not null then',
'    apex_json.open_object;',
'    apex_json.write(''success'', TRUE);',
'    apex_json.write(''mitarbeiter_sperre'', mitarbeiter_sperre);',
'    apex_json.close_object; ',
'   else',
'    apex_json.open_object;',
'    apex_json.write(''success'', FALSE);',
'    apex_json.write(''sum'', 0);',
'    apex_json.close_object; ',
'   end if;',
'END;'))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp.component_end;
end;
/
