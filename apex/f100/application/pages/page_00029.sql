prompt --application/pages/page_00029
begin
--   Manifest
--     PAGE: 00029
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
 p_id=>29
,p_name=>'Rufbereitschaft'
,p_alias=>'RUFBEREITSCHAFT'
,p_page_mode=>'MODAL'
,p_step_title=>'Rufbereitschaft'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*// Code zur Initialisierung des Dialogs',
'function initDialog() {',
unistr('  // Code zur Initialisierung des Dialogs hier einf\00FCgen'),
'}',
'',
unistr('// Code zum \00D6ffnen des Dialogs'),
'function openDialog() {',
'  apex.navigation.dialog(''dialog_page_url'', {',
'    title: ''Dialogtitel'',',
'    height: ''600'',',
'    width: ''700'',',
'    maxWidth: ''200'',',
'    modal: true,',
'    dialog: null',
'  });',
'}',
'',
unistr('// Code zum Schlie\00DFen des Dialogs'),
'function closeDialog() {',
'  apex.navigation.dialog.close(true);',
'}',
'',
'// Code zum Abbrechen des Dialogs',
'function cancelDialog() {',
'  apex.navigation.dialog.close(false);',
'}',
'',
'// Code zum Binden der Funktionen an Ereignisse',
'$(document).ready(function() {',
'  apex.jQuery("#cr_sp_matrix").on("dialogopen", initDialog);',
'});',
'*/'))
,p_step_template=>wwv_flow_imp.id(98903941265580497)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'1000'
,p_dialog_width=>'800'
,p_dialog_max_width=>'800'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230901145031'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(116944707121009061)
,p_plug_name=>'RB'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'RUFBEREITSCHAFT'
,p_query_where=>wwv_flow_string.join(wwv_flow_t_varchar2(
'trunc(datum, ''MM'') = trunc(to_date(:P29_DATUM, ''MON YYYY''), ''MM'')',
''))
,p_query_order_by_type=>'STATIC'
,p_query_order_by=>'datum'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P29_DATUM'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'RB'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(116944543500009059)
,p_name=>'DATUM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATUM'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Datum'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(116944458243009058)
,p_name=>'MITARBEITER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MITARBEITER_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_AUTO_COMPLETE'
,p_heading=>'Mitarbeiter '
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
,p_is_required=>false
,p_max_length=>20
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(98382786148341239)
,p_lov_display_extra=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(116944390538009057)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(116944268589009056)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(116944622154009060)
,p_internal_uid=>146323380902971934
,p_is_editable=>true
,p_edit_operations=>'u:d'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_no_data_found_message=>unistr('Noch kein MA f\00FCr den &:P29_DATUM. hinterlegt.')
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(115998152123255778)
,p_interactive_grid_id=>wwv_flow_imp.id(116944622154009060)
,p_static_id=>'1472699'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(115997919459255779)
,p_report_id=>wwv_flow_imp.id(115998152123255778)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115997455113255785)
,p_view_id=>wwv_flow_imp.id(115997919459255779)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(116944543500009059)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84.79169999999999
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115996532465255790)
,p_view_id=>wwv_flow_imp.id(115997919459255779)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(116944458243009058)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>432.20799999999997
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115993498820273953)
,p_view_id=>wwv_flow_imp.id(115997919459255779)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(116944390538009057)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(165669793690571462)
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
 p_id=>wwv_flow_imp.id(116253893129354359)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(165669793690571462)
,p_button_name=>'CANCEL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'Abbrechen'
,p_button_position=>'CLOSE'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(116254260768354355)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(165669793690571462)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(98792645238580445)
,p_button_image_alt=>'speichern'
,p_button_position=>'NEXT'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(116249742096354413)
,p_name=>'P29_DATUM'
,p_item_sequence=>40
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(116943531688009049)
,p_name=>'onSaveRBClicked'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(116254260768354355)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(116943465559009048)
,p_event_id=>wwv_flow_imp.id(116943531688009049)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// Annahme: ''newValue'' enth\00E4lt den neuen Wert, den Sie an die Matrix-Seite \00FCbertragen m\00F6chten'),
'const newValue = ''test'';',
'',
'// Datenstruktur erstellen',
'const eventData = {',
'  newValue: newValue',
'};',
'',
unistr('// Event ausl\00F6sen und Daten \00FCbergeben'),
'document.dispatchEvent(new CustomEvent(''rbSaved'', { detail: eventData }));',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(116943217156009046)
,p_event_id=>wwv_flow_imp.id(116943531688009049)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(116944194189009055)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(116944707121009061)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'RB - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(116254260768354355)
,p_internal_uid=>17091520353284237
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(115754398469113793)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CloseDialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>18281316073179499
);
wwv_flow_imp.component_end;
end;
/
