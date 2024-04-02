prompt --application/shared_components/logic/application_processes/get_comment_mitarbeiter
begin
--   Manifest
--     APPLICATION PROCESS: get_comment_mitarbeiter
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
 p_id=>wwv_flow_imp.id(118721248973370253)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_comment_mitarbeiter'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_comments VARCHAR2(200);',
'  p_datum VARCHAR2(200);',
'  p_mitarbeiter_id VARCHAR2(200);',
'BEGIN',
'  p_datum := apex_application.g_x05;',
'  p_mitarbeiter_id := apex_application.g_x06;',
'  ',
'  BEGIN',
'    SELECT kommentar',
'    INTO v_comments',
'    FROM planung_schichten',
'    WHERE TO_CHAR(datum, ''DD.MM.YYYY'') = p_datum',
'    AND mitarbeiter_id = p_mitarbeiter_id',
'    AND kommentar IS NOT NULL;',
'    ',
'    APEX_JSON.OPEN_OBJECT;',
'    APEX_JSON.WRITE(''success'', TRUE);',
'    APEX_JSON.WRITE(''comment'', v_comments);',
'    APEX_JSON.CLOSE_OBJECT;',
'    ',
'  EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'      v_comments := ''''; -- Setzen des leeren Kommentarwerts',
'      APEX_JSON.OPEN_OBJECT;',
'      APEX_JSON.WRITE(''success'', TRUE);',
'      APEX_JSON.WRITE(''comment'', v_comments);',
'      APEX_JSON.CLOSE_OBJECT;',
'      ',
'    WHEN OTHERS THEN',
'      APEX_JSON.OPEN_OBJECT;',
'      APEX_JSON.WRITE(''success'', FALSE);',
'      APEX_JSON.WRITE(''comment'', ''-'');',
'      APEX_JSON.WRITE(''err'', SQLERRM);',
'      APEX_JSON.CLOSE_OBJECT;',
'  END;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
