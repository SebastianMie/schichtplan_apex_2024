prompt --application/pages/page_00047
begin
--   Manifest
--     PAGE: 00047
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
 p_id=>47
,p_name=>unistr('Password \00E4ndern')
,p_alias=>unistr('PASSWORD-\00C4NDERN')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Password \00E4ndern')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'350'
,p_dialog_width=>'700'
,p_dialog_max_width=>'200'
,p_protection_level=>'C'
,p_page_component_map=>'16'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230817223548'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(22161098795861024)
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
 p_id=>wwv_flow_imp.id(113962204855288664)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(22161098795861024)
,p_button_name=>'CANCEL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'CLOSE'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(113961965203288666)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(22161098795861024)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'speichern'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(115752028333113770)
,p_name=>'P47_CURR_PASS'
,p_is_required=>true
,p_item_sequence=>10
,p_prompt=>'Aktuelles Passwort'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(115751950308113769)
,p_name=>'P47_NEW_PASS'
,p_is_required=>true
,p_item_sequence=>20
,p_prompt=>'Neues Passwort'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(115751853519113768)
,p_name=>'P47_CONF_PASS'
,p_is_required=>true
,p_item_sequence=>30
,p_prompt=>unistr('Passwort best\00E4tigen')
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(98795537782580449)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(115751501122113764)
,p_name=>'P47_MITARBEITER_ID'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(115751766585113767)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_password VARCHAR2(100);',
'  l_confirm_password VARCHAR2(100);',
'  l_mitarbeiter_id mitarbeiter.mitarbeiter_id%TYPE;',
'BEGIN',
'  -- Set the employee ID and password values',
'  l_mitarbeiter_id := :P47_MITARBEITER_ID; ',
unistr('  l_password := :P47_NEW_PASS; -- Verstecktes Item f\00FCr das unmaskierte Passwort'),
unistr('  l_confirm_password  := :P47_CONF_PASS; -- Verstecktes Item f\00FCr das unmaskierte Best\00E4tigungspasswort'),
'  utility_pkg.update_password_hash(l_mitarbeiter_id, l_password, l_confirm_password);',
'',
'  :P47_CURR_PASS := null;  ',
'  :P47_NEW_PASS := null;',
'  :P47_CONF_PASS := null;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>18283947957179525
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(113958191753288728)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CloseDialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>20077522789004564
);
wwv_flow_imp.component_end;
end;
/
