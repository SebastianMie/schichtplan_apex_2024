prompt --application/pages/page_00038
begin
--   Manifest
--     PAGE: 00038
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
 p_id=>38
,p_name=>'archiv verwaltung'
,p_alias=>'ARCHIV-VERWALTUNG'
,p_page_mode=>'MODAL'
,p_step_title=>'Archiv Verwaltung'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'600'
,p_dialog_width=>'700'
,p_dialog_max_width=>'200'
,p_protection_level=>'C'
,p_page_component_map=>'17'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230621124222'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17328199324400464)
,p_plug_name=>'Button Container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98882280679580484)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(118795122045749145)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(17328199324400464)
,p_button_name=>'CANCEL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'CLOSE'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(118794342945749143)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(17328199324400464)
,p_button_name=>'ARCHIVE_DATA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Daten archivieren'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_confirm_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Der ausgew\00E4hlte Monat wird in das Archiv verschoben.'),
unistr('Archivieren best\00E4tigen.')))
,p_confirm_style=>'warning'
,p_icon_css_classes=>'fa-archive'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(121960361537866554)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(17328199324400464)
,p_button_name=>'RECOVER_DATA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Daten wiederherstellen'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_confirm_message=>unistr('Der ausgew\00E4hlte Monat wird aus dem Archiv wieder hergestellt. Weiderherstellung best\00E4tigen.')
,p_confirm_style=>'warning'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(121960150694866552)
,p_name=>'P38_MONAT_JAHR'
,p_item_sequence=>20
,p_prompt=>'Monat '
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'MONAT JAHR ALL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select monat_jahr d, monat_jahr r',
'from monat_planung',
'order by TO_DATE(monat_jahr, ''MON YYYY'')',
''))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(118791016761749097)
,p_name=>'onArchiveDataClicked'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(118794342945749143)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(118790540043749096)
,p_event_id=>wwv_flow_imp.id(118791016761749097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'archiv_pkg.archive_data(:P38_MONAT_JAHR);'
,p_attribute_02=>'P38_MONAT_JAHR'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121959597793866546)
,p_event_id=>wwv_flow_imp.id(118791016761749097)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(121960094332866551)
,p_name=>'onRecoverDataClicked'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(121960361537866554)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121959954054866550)
,p_event_id=>wwv_flow_imp.id(121960094332866551)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'archiv_pkg.recover_data(:P38_MONAT_JAHR);'
,p_attribute_02=>'P38_MONAT_JAHR'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(121959497509866545)
,p_event_id=>wwv_flow_imp.id(121960094332866551)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(118791429090749098)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CloseDialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>15244285451544194
);
wwv_flow_imp.component_end;
end;
/
