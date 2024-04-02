prompt --application/shared_components/logic/application_processes/save_rb_ma
begin
--   Manifest
--     APPLICATION PROCESS: save_rb_ma
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
 p_id=>wwv_flow_imp.id(118720839312177648)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save_rb_ma'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'DECLARE',
'    p_datum DATE;',
'    p_mitarbeiter_id VARCHAR2(50);',
'    v_success VARCHAR2(5);',
'BEGIN',
'    p_datum := apex_application.g_x10;',
'    p_mitarbeiter_id := apex_application.g_x11;',
'',
'    v_success := utility_pkg.save_rb_ma(p_datum, p_mitarbeiter_id);',
'',
'    IF v_success = ''true'' THEN',
'        apex_json.open_object;',
'        apex_json.write(''success'', TRUE);',
'        apex_json.write(''mitarbeiter_id'', p_mitarbeiter_id);',
'        apex_json.write(''datum'', p_datum);',
'        apex_json.close_object; ',
'    ELSE',
'        apex_json.open_object;',
'        apex_json.write(''success'', FALSE);',
'        apex_json.write(''mitarbeiter_id'', p_mitarbeiter_id);',
'        apex_json.write(''datum'', p_datum);',
unistr('        apex_json.write(''err'', ''Ung\00FCltiger Vorgabe Code'');'),
'        apex_json.close_object;',
'    END IF;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
