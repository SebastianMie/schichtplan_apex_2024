prompt --application/pages/page_00028
begin
--   Manifest
--     PAGE: 00028
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
 p_id=>28
,p_name=>'Kalendar'
,p_alias=>'KALENDAR'
,p_step_title=>'Kalendar'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function colorEvents() {',
'  // Define the color for each value',
'  const colorMap = {',
'    ''ab6'': ''#FFC0CB'',',
'    ''ab7'': ''#F08080'',',
'    ''ab12'': ''#90EE90'',',
'    ''ab14'': ''#00CED1''',
'  };',
'  ',
'  // Get the calendar widget by static id',
'  const calendar = apex.jQuery(''#${makalendar}'').data(''calendar'');',
'  ',
'  // Loop through each event and set its color based on its value',
'  calendar.getEvents().forEach(event => {',
'    const value = event.data.value;',
'    if (value && colorMap[value]) {',
'      event.setColor(colorMap[value]);',
'    }',
'  });',
'}',
'',
'function colorCodeEvents() {',
'  // Define the color for each value',
'  const colorMap = {',
'    ''ab6'': ''#FFC0CB'',',
'    ''ab7'': ''#F08080'',',
'    ''ab12'': ''#90EE90'',',
'    ''ab14'': ''#00CED1''',
'  };',
'',
'  var cal = "#" + apex.item("makalendar").getValue();',
'  $(cal).find(''.fc-event-container'').each(function() {',
'    var eventTitle = $(this).find(''.fc-title'').text();',
'    if (eventTitle && colorMap[eventTitle]) {',
'      $(this).css(''background-color'', colorMap[eventTitle]);',
'    }',
'  });',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'08'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230509175156'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(122848255239482878)
,p_plug_name=>'Kalendar'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useRegionTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98877814156580483)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(98915417889580516)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(98791364244580444)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12904870760693932)
,p_plug_name=>'Mitarbeiter kalendar'
,p_region_name=>'makalender'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'TABLE'
,p_query_table=>'PLANUNG_SCHICHTEN'
,p_query_where=>'mitarbeiter_id = :APP_USER'
,p_include_rowid_column=>false
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_CSS_CALENDAR'
,p_attribute_01=>'STARTZEIT'
,p_attribute_02=>'ENDZEIT'
,p_attribute_03=>'VORGABE_CODE_ID'
,p_attribute_04=>'PLANUNG_SCHICHTEN_ID'
,p_attribute_07=>'N'
,p_attribute_11=>'month:week:day:list:navigation'
,p_attribute_13=>'Y'
,p_attribute_17=>'Y'
,p_attribute_18=>'00'
,p_attribute_19=>'Y'
,p_attribute_20=>'6'
,p_attribute_21=>'10'
,p_attribute_22=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(123057506122697733)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(12904870760693932)
,p_button_name=>'monatPlanung'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Monat Planung bearbeiten'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:25:&SESSION.::&DEBUG.:25:P25_MITARBEITER_ID:&P28_MITARBEITER_ID.'
,p_icon_css_classes=>'fa-pencil'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122848740555482883)
,p_name=>'P28_MITARBEITER_ID'
,p_item_sequence=>120
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122848628992482882)
,p_name=>'P28_VORNAME'
,p_item_sequence=>130
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122848567106482881)
,p_name=>'P28_NACHNAME'
,p_item_sequence=>140
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122848422092482880)
,p_name=>'P28_EMAIL_ADRESSE'
,p_item_sequence=>150
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(122848373169482879)
,p_name=>'P28_HANDYNUMMER'
,p_item_sequence=>160
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(123054108706697718)
,p_name=>'setGlobalItems'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(123053170437697714)
,p_event_id=>wwv_flow_imp.id(123054108706697718)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mitarbeiter_id Mitarbeiter.mitarbeiter_id%type;',
'    l_vorname Mitarbeiter.vorname%type;',
'    l_nachname Mitarbeiter.nachname%type;',
'    l_email_adresse Mitarbeiter.email_adresse%type;',
'    l_handynummer Mitarbeiter.handynummer%type;',
'    l_service_team_id Mitarbeiter.service_team_id%type;',
'    l_aktiv Mitarbeiter.aktiv%type;',
'begin',
'    select mitarbeiter_id, vorname, nachname, email_adresse, handynummer, service_team_id, aktiv',
'    into l_mitarbeiter_id, l_vorname, l_nachname, l_email_adresse, l_handynummer, l_service_team_id, l_aktiv',
'    from mitarbeiter',
'    where mitarbeiter_id = :APP_USER;',
'',
'    apex_util.set_session_state(''P28_MITARBEITER_ID'', l_mitarbeiter_id);',
'    apex_util.set_session_state(''P28_VORNAME'', l_vorname);',
'    apex_util.set_session_state(''P28_NACHNAME'', l_nachname);',
'    apex_util.set_session_state(''P28_EMAIL_ADRESSE'', l_email_adresse);',
'    apex_util.set_session_state(''P28_HANDYNUMMER'', l_handynummer);',
'    --apex_util.set_session_state(''P28_AKTIV'', l_aktiv);',
unistr('    -- leere Datens\00E4tze f\00FCr Drag and Drop Funktionalit\00E4t Kalender werden ermittelt und geupdated'),
'    utility_pkg.update_planung_schichten_zeitraum();',
'exception',
'    when no_data_found then',
'        apex_debug.message(''No data found for user '' || :APP_USER);',
'end;'))
,p_attribute_02=>'APP_USER'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(123053655307697715)
,p_event_id=>wwv_flow_imp.id(123054108706697718)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(12904870760693932)
,p_attribute_01=>'//colorCodeEvents();'
);
wwv_flow_imp.component_end;
end;
/
