prompt --application/shared_components/logic/application_processes/get_limit_h_mitarbeiter
begin
--   Manifest
--     APPLICATION PROCESS: get_limit_h_mitarbeiter
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
 p_id=>wwv_flow_imp.id(126166814585203806)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_limit_h_mitarbeiter'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   p_mitarbeiter_id varchar2(50);',
'   p_monat_jahr varchar2(50);',
'   p_land_id varchar2(8 char);',
'   p_monat_planung_id number;',
'   p_limit_h number;',
'begin',
'   p_mitarbeiter_id := apex_application.g_x04;',
'   p_monat_jahr := apex_application.g_x03;',
'   p_limit_h := 0;',
'',
'   begin',
'      select monat_planung_id ',
'      into p_monat_planung_id',
'      from monat_planung',
'      where monat_jahr = p_monat_jahr;',
'',
'      select land_id ',
'      into p_land_id',
'      from mitarbeiter',
'      where mitarbeiter_id = p_mitarbeiter_id;',
'',
'      if p_monat_planung_id is not null then',
'         select limit_h ',
'         into p_limit_h',
'         from laender_monat_limit',
'         where land_id = p_land_id',
'         and monat_planung_id = p_monat_planung_id;',
'      end if;',
'',
'      if sqlcode = 0 then',
'         apex_json.open_object;',
'         apex_json.write(''success'', true);',
'         apex_json.write(''limit_h'', p_limit_h);',
'         apex_json.close_object; ',
'      else',
'         apex_json.open_object;',
'         apex_json.write(''success'', false);',
'         apex_json.write(''limit_h'', 0);',
'         apex_json.write(''err'', sqlerrm);',
'         apex_json.close_object;',
'      end if;',
'   exception',
'      when no_data_found then',
'         -- Keine Daten gefunden, setze sqlcode auf -1403',
'         apex_json.open_object;',
'         apex_json.write(''success'', true);',
'         apex_json.write(''limit_h'', 0);',
'         apex_json.close_object;',
'   end;',
'end;'))
,p_process_clob_language=>'PLSQL'
);
wwv_flow_imp.component_end;
end;
/
