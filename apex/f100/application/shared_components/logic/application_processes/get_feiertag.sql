prompt --application/shared_components/logic/application_processes/get_feiertag
begin
--   Manifest
--     APPLICATION PROCESS: get_Feiertag
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
 p_id=>wwv_flow_imp.id(118437466663970064)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_Feiertag'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'v_feiertag_bezeichnung varchar2(200);',
'v_land VARCHAR2(200);',
'p_datum VARCHAR2(200);',
'BEGIN',
'',
' p_datum := apex_application.g_x08;',
'',
'        SELECT bezeichnung, land ',
'        INTO v_feiertag_bezeichnung, v_land',
'        from ref_feiertag',
'        WHERE TO_CHAR(datum, ''DD.MM.YYYY'') = p_datum;',
'',
'      APEX_JSON.OPEN_OBJECT;',
'      APEX_JSON.WRITE(''success'', TRUE);',
'      APEX_JSON.WRITE(''feiertag_bezeichnung'', v_feiertag_bezeichnung);',
'      APEX_JSON.WRITE(''land'', v_land);',
'      APEX_JSON.CLOSE_OBJECT;',
'    ',
'  EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'      v_feiertag_bezeichnung := '''';',
'      v_land := '''';',
'      APEX_JSON.OPEN_OBJECT;',
'      APEX_JSON.WRITE(''success'', FALSE);',
'      APEX_JSON.WRITE(''feiertag_bezeichnung'', v_feiertag_bezeichnung);',
'      APEX_JSON.WRITE(''land'', v_land);',
'      APEX_JSON.CLOSE_OBJECT;',
'      ',
'    WHEN OTHERS THEN',
'      APEX_JSON.OPEN_OBJECT;',
'      APEX_JSON.WRITE(''success'', FALSE);',
'      APEX_JSON.WRITE(''feiertag_bezeichnung'', ''-'');',
'      APEX_JSON.WRITE(''land'', ''-'');',
'      APEX_JSON.WRITE(''err'', SQLERRM);',
'      APEX_JSON.CLOSE_OBJECT;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
