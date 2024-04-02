prompt --application/pages/page_00060
begin
--   Manifest
--     PAGE: 00060
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_page.create_page(
 p_id=>60
,p_name=>'Mitarbeiter Kalendar'
,p_alias=>'MITARBEITER-KALENDAR'
,p_step_title=>'Mitarbeiter Kalendar'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'08'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230316201421'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(98354632681933073)
,p_plug_name=>'Schichtplanung'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(98884152106580485)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_query_type=>'TABLE'
,p_query_table=>'PLANUNG_SCHICHTEN_CODES_V'
,p_query_where=>'mitarbeiter_id = :P60_MITARBEITER_AUSWAHL'
,p_include_rowid_column=>false
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CSS_CALENDAR'
,p_ajax_items_to_submit=>'P60_MITARBEITER_AUSWAHL'
,p_attribute_01=>'STARTZEIT'
,p_attribute_02=>'ENDZEIT'
,p_attribute_03=>'BEZEICHNUNG_KUERZEL'
,p_attribute_04=>'PLANUNG_SCHICHTEN_ID'
,p_attribute_05=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.:::'
,p_attribute_06=>'f?p=&APP_ID.:50:&SESSION.::&DEBUG.:50::'
,p_attribute_07=>'Y'
,p_attribute_08=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    update planung_schichten',
'       set startzeit = to_date(:APEX$NEW_START_DATE, ''YYYYMMDDHH24MISS''),',
'           endzeit = to_date(:APEX$NEW_END_DATE, ''YYYYMMDDHH24MISS'')',
'     where planung_schichten_id = :APEX$PK_VALUE;',
'end;'))
,p_attribute_10=>'ICAL'
,p_attribute_11=>'month:week:day:list:navigation'
,p_attribute_13=>'Y'
,p_attribute_16=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Mitarbeiter: &KUERZEL. </br>',
'',
unistr('T\00E4tigkeit: &BESCHREIBUNG.')))
,p_attribute_17=>'Y'
,p_attribute_18=>'00'
,p_attribute_19=>'Y'
,p_attribute_20=>'6'
,p_attribute_21=>'10'
,p_attribute_22=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(98354434089933071)
,p_plug_name=>'container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(98223682521067710)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98877814156580483)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(98915417889580516)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(98791364244580444)
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(127059646982634329)
,p_name=>'P60_MONAT_STATUS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(98354434089933071)
,p_prompt=>'Monat Status'
,p_source=>'return utility_pkg.get_status(:P25_MONTH);'
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(98354592219933072)
,p_name=>'P60_MITARBEITER_AUSWAHL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(98354434089933071)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(98352302758933050)
,p_name=>'P60_MONAT_FILTER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(98354434089933071)
,p_item_default=>'sysdate'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_prompt=>'Monat Filter'
,p_format_mask=>'MM'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(98354381983933070)
,p_name=>'onMitarbeiterAuswahlChange'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P60_MITARBEITER_AUSWAHL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(98145713813425088)
,p_event_id=>wwv_flow_imp.id(98354381983933070)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P60_SUM_MA_STD'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUM(vc.dauer_h) FROM planung_schichten ps',
'JOIN vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id ',
'WHERE ps.mitarbeiter_id = :P60_MITARBEITER_AUSWAHL',
'AND to_char(ps.datum,''mm'') = ''12''--to_char(:P60_MONAT_FILTER)--:P60_MONAT_FILTER--''12'''))
,p_attribute_07=>'P60_MITARBEITER_AUSWAHL'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(98354203827933069)
,p_event_id=>wwv_flow_imp.id(98354381983933070)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(98354632681933073)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(98352471267933051)
,p_event_id=>wwv_flow_imp.id(98354381983933070)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P60_SUM_MA_STD'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(98146228429425093)
,p_name=>'onMonatFilterChange'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P60_MONAT_FILTER'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(98145816675425089)
,p_event_id=>wwv_flow_imp.id(98146228429425093)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P60_SUM_MA_STD'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUM(vc.dauer_h) FROM planung_schichten ps',
'JOIN vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id ',
'WHERE ps.mitarbeiter_id = :P60_MITARBEITER_AUSWAHL',
'AND to_char(ps.datum,''mm'') = ''12''--to_char(:P60_MONAT_FILTER)--:P60_MONAT_FILTER--''12'''))
,p_attribute_07=>'P60_MITARBEITER_AUSWAHL'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(98146116244425092)
,p_event_id=>wwv_flow_imp.id(98146228429425093)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P60_SUM_MA_STD'
);
wwv_flow_imp.component_end;
end;
/
