prompt --application/shared_components/logic/application_processes/get_comment_count
begin
--   Manifest
--     APPLICATION PROCESS: get_comment_count
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
 p_id=>wwv_flow_imp.id(117445584996190379)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_comment_count'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_comment_count NUMBER;',
'  p_datum VARCHAR2(200);',
'BEGIN',
'  p_datum := apex_application.g_x01;',
'',
'SELECT count(datum)',
'INTO v_comment_count',
'FROM kommentare',
'WHERE datum = TO_DATE(p_datum, ''DD.MM.YYYY'')',
'AND kommentar IS NOT NULL;',
'',
'  IF SQLCODE = 0 THEN',
'    APEX_JSON.OPEN_OBJECT;',
'    APEX_JSON.WRITE(''success'', TRUE);',
'    APEX_JSON.WRITE(''comment_count'', v_comment_count);',
'    APEX_JSON.CLOSE_OBJECT;',
'  ELSE',
'    APEX_JSON.OPEN_OBJECT;',
'    APEX_JSON.WRITE(''success'', FALSE);',
'    APEX_JSON.WRITE(''comment_count'', 0);',
'    APEX_JSON.WRITE(''err'', SQLERRM);',
'    APEX_JSON.CLOSE_OBJECT;',
'  END IF;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
