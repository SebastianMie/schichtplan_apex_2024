prompt --application/pages/page_00065
begin
--   Manifest
--     PAGE: 00065
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
 p_id=>65
,p_name=>unistr('L\00E4nder Monat Limit')
,p_alias=>unistr('L\00C4NDER-MONAT-LIMIT')
,p_step_title=>unistr('L\00E4nder Monat Limit')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'21'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20230726180933'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(115753139751113781)
,p_plug_name=>'Filter'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98846167001580472)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(194083326879596010)
,p_plug_name=>unistr('L\00E4nder Limit')
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98884152106580485)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select lm.land_monat_limit_id,',
'       lm.monat_planung_id,',
'       lm.land_id,',
'       lm.limit_h,',
'       mp.monat_jahr',
'from LAND_MONAT_LIMIT lm',
'join monat_planung mp on mp.monat_planung_id = lm.monat_planung_id',
'where mp.monat_jahr = :P65_MONTH'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P65_MONTH'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>unistr('L\00E4nder Limit')
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
 p_id=>wwv_flow_imp.id(115752873402113778)
,p_name=>'LAND_MONAT_LIMIT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAND_MONAT_LIMIT_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(115752748903113777)
,p_name=>'MONAT_PLANUNG_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MONAT_PLANUNG_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(115752672124113776)
,p_name=>'LAND_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAND_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Land'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(115752589383113775)
,p_name=>'LIMIT_H'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LIMIT_H'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Limit (Std.)'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_attribute_04=>'text'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(115752425998113774)
,p_name=>'MONAT_JAHR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MONAT_JAHR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Monat'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(194086874812596045)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(194086987107596046)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(194083489939596011)
,p_internal_uid=>457351492996577005
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
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
 p_id=>wwv_flow_imp.id(194105413067662664)
,p_interactive_grid_id=>wwv_flow_imp.id(194083489939596011)
,p_static_id=>'333005'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(194105604153662664)
,p_report_id=>wwv_flow_imp.id(194105413067662664)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115620746655474035)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(115752873402113778)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115619810159474041)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(115752748903113777)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115618905827474044)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(115752672124113776)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>182.45799999999997
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115618071854474046)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(115752589383113775)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(115617199555474048)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(115752425998113774)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>150.45799999999997
,p_break_order=>5
,p_break_is_enabled=>true
,p_break_sort_direction=>'ASC'
,p_break_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(194298430491106624)
,p_view_id=>wwv_flow_imp.id(194105604153662664)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(194086874812596045)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>48
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(115752987958113779)
,p_name=>'P65_MONTH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(115753139751113781)
,p_prompt=>'Monat'
,p_source=>'SELECT TO_CHAR(SYSDATE, ''MON YYYY'') FROM DUAL;'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'MONAT JAHR ALL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select monat_jahr d, monat_jahr r',
'from monat_planung',
'order by TO_DATE(monat_jahr, ''MON YYYY'')',
''))
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
 p_id=>wwv_flow_imp.id(115752397552113773)
,p_name=>'onMonthChange'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P65_MONTH'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(115752227439113772)
,p_event_id=>wwv_flow_imp.id(115752397552113773)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(194083326879596010)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(115624851543141868)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(194083326879596010)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('update l\00E4nder limit')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>18410862999151424
);
wwv_flow_imp.component_end;
end;
/
