prompt --application/shared_components/logic/application_processes/save_matrix_mitarbeiter
begin
--   Manifest
--     APPLICATION PROCESS: save_matrix_mitarbeiter
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
 p_id=>wwv_flow_imp.id(130948509358499764)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save_matrix_mitarbeiter'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    p_matrix_data matrix_table_type := matrix_table_type(); -- Leeres Array des benutzerdefinierten Typs initialisieren',
'    p_missing_entries varchar(4000);',
'    ',
'BEGIN',
unistr('    -- Bef\00FCllen des Arrays mit Daten aus der JSON-Array-Zeichenfolge'),
'    FOR rec IN (SELECT * FROM JSON_TABLE(apex_application.g_x01, ''$[*]'' COLUMNS (',
'                    datum VARCHAR2(20) PATH ''$.datum'',',
'                    currentUser VARCHAR2(20) PATH ''$.currentUser'',',
'                    value VARCHAR2(100) PATH ''$.value''',
'                ))) LOOP',
unistr('        -- Daten in das benutzerdefinierte Matrix-Array einf\00FCgen'),
'        p_matrix_data.EXTEND;',
'        p_matrix_data(p_matrix_data.LAST) := matrix_row_type(',
'            TO_DATE(rec.datum, ''DD.MM.YYYY''),',
'            rec.currentUser,',
'            rec.value',
'        );',
'        ',
'    END LOOP;',
'    ',
'    -- Aufruf der Prozedur zur Verarbeitung des gesamten Arrays',
'    p_missing_entries := utility_pkg.save_matrix_mitarbeiter(p_matrix_data);',
'',
unistr('    -- Durchlaufen des Arrays der fehlenden Eintr\00E4ge und Hinzuf\00FCgen zum JSON-Array'),
unistr('        -- R\00FCckgabe des JSON-Arrays f\00FCr fehlende Eintr\00E4ge'),
'        apex_json.open_object;',
'        apex_json.write(''success'', TRUE);',
'        apex_json.write(''missing_entries'', p_missing_entries );',
'        apex_json.close_object;',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        -- Fehlerbehandlung: Protokollieren Sie den Fehler und geben Sie ihn an die JavaScript-Seite weiter',
'        apex_debug.error(''Error: '' || SQLERRM);',
'        apex_json.open_object;',
'        apex_json.write(''success'', FALSE);',
'        apex_json.write(''error'', SQLERRM);',
'        apex_json.close_object;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
wwv_flow_imp.component_end;
end;
/
