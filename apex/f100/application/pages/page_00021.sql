prompt --application/pages/page_00021
begin
--   Manifest
--     PAGE: 00021
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
 p_id=>21
,p_name=>'Schichtplanung'
,p_alias=>'SCHICHTPLANUNG'
,p_step_title=>'Schichtplanung'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function faerbe_zellen_ein() {',
'    $(''#ig_schichtplanung table'').find(''tr[data-rownum]'').each(function(){',
'        $(this).find(''td:not(.is-readonly)'').each(function(){',
'            switch($(this).text()){',
'                case '''': $(this).css("background-color", "#f9f9f9"); break;',
'                case ''ab6'': $(this).css("background-color", "#ffc000"); break;',
'                case ''ab7'': $(this).css("background-color", "#ffff00"); break;',
'                case ''ab9'': $(this).css("background-color", "#fcd5b4"); break;',
'                case ''ab14'': $(this).css("background-color", "#da9694"); break;',
'                case ''ab22'': $(this).css("background-color", "#a6a6a6"); break;',
'                case ''krank'': $(this).css("background-color", "#c5d798"); break;',
'                case ''Urlaub'': $(this).css("background-color", "#98d046"); break;',
'                case ''Schulung'': $(this).css("background-color", "#3db1f3"); break;',
'                default: $(this).css("background-color", "red");',
'            }',
'        });',
'    }); ',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'21'
,p_last_updated_by=>'THF'
,p_last_upd_yyyymmddhh24miss=>'20230127133128'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(63435205862738612)
,p_plug_name=>'Schichtplanung'
,p_region_name=>'ig_schichtplanung'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(98884152106580485)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT *',
'FROM (SELECT TRUNC(ps.datum) datum,',
'             ps.wochentag,',
'             vc.bezeichnung_kuerzel,',
'             ps.mitarbeiter_id',
'      FROM planung_schichten ps',
'      JOIN vorgabe_codes vc ON vc.vorgabe_code_id = ps.vorgabe_code_id)',
'PIVOT(',
'    MAX(bezeichnung_kuerzel)',
'    FOR mitarbeiter_id IN (''LAM'' as lam,',
'                           ''MKP'' as mkp)',
');'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Schichtplanung'
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
 p_id=>wwv_flow_imp.id(97665201970180769)
,p_name=>'LAM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAM'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Lam'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(97665133708180768)
,p_name=>'MKP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MKP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Mkp'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(63434942272738609)
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
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(63434858165738608)
,p_name=>'WOCHENTAG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WOCHENTAG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Wochentag'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62839330857247315)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_display_condition_type=>'NEVER'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(62839243451247314)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_display_condition_type=>'NEVER'
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(63435108381738611)
,p_internal_uid=>68198893146751886
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
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
 p_id=>wwv_flow_imp.id(63409047911720748)
,p_interactive_grid_id=>wwv_flow_imp.id(63435108381738611)
,p_static_id=>'337599'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(63408868020720748)
,p_report_id=>wwv_flow_imp.id(63409047911720748)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(97096777383204518)
,p_view_id=>wwv_flow_imp.id(63408868020720748)
,p_display_seq=>26
,p_column_id=>wwv_flow_imp.id(97665201970180769)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(97095878126204516)
,p_view_id=>wwv_flow_imp.id(63408868020720748)
,p_display_seq=>27
,p_column_id=>wwv_flow_imp.id(97665133708180768)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(63407421264720745)
,p_view_id=>wwv_flow_imp.id(63408868020720748)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(63434942272738609)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(63406579409720743)
,p_view_id=>wwv_flow_imp.id(63408868020720748)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(63434858165738608)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(62772517635863949)
,p_view_id=>wwv_flow_imp.id(63408868020720748)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(62839330857247315)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(97157375253164279)
,p_name=>'Autocomplete Zelle'
,p_event_sequence=>60
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(63435205862738612)
,p_triggering_element=>'LAM,MKP'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'focusout'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(97156866894164278)
,p_event_id=>wwv_flow_imp.id(97157375253164279)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'switch($(this.triggeringElement).val()){',
'    case ''6'': $(this.triggeringElement).val(''ab6''); break;',
'    case ''7'': $(this.triggeringElement).val(''ab7''); break;',
'    case ''9'': $(this.triggeringElement).val(''ab9''); break;',
'    case ''14'': $(this.triggeringElement).val(''ab14''); break;',
'    case ''22'': $(this.triggeringElement).val(''ab22''); break;',
'    case ''k'': $(this.triggeringElement).val(''krank''); break;',
'    case ''u'': $(this.triggeringElement).val(''Urlaub''); break;',
'    case ''s'': $(this.triggeringElement).val(''Schulung''); break;',
'};',
'setTimeout(() => faerbe_zellen_ein(), 10);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(97664824975180765)
,p_name=>'Init Grid'
,p_event_sequence=>70
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(97664705002180764)
,p_event_id=>wwv_flow_imp.id(97664824975180765)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.region("ig_schichtplanung").call("getActions").set("edit", true);',
'apex.region("ig_schichtplanung").call("getActions").hide("edit");',
'',
'faerbe_zellen_ein();'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(97301577690573458)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(63435205862738612)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'New'
,p_attribute_01=>'PLSQL_CODE'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--BEGIN',
'--SOLUTION_DESK_GRID_PKG.save_solution_desk_grid_col(:datum,:wochentag,:LMA,:MKP,:LSZ);',
'--END;',
'DECLARE',
'',
'BEGIN',
'     INSERT INTO mitarbeiter (kuerzel)',
'     VALUES (''TESTHTHF'');',
'       --create new collection',
'    /*APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION (',
'        p_collection_name => ''SOLUTION_DESK_PLANUNG''',
'    ); ',
'    --adding members from column Values',
'    APEX_COLLECTION.ADD_MEMBER (',
'    p_collection_name => ''SOLUTION_DESK_PLANUNG'',',
'    p_d001 => :DATUM,',
'    p_c001 => :WOCHENTAG,',
'    p_c002 => :LMA,',
'    p_c003 => :MKP',
'    );*/',
'    /*',
'    APEX_COLLECTION.ADD_MEMBER (',
'    p_collection_name => l_coll_name,',
'    p_d001 => :datum,',
'    p_c001 => :wochentag,',
'    p_c002 => :LMA,',
'    p_c003 => :MKP,',
'    p_c004 => :LSZ,',
'    p_c005 => :ALC,',
'    p_c006 => :PSZ,',
'    p_c007 => :MKO,',
'    p_c008 => :PAM,',
'    p_c009 => :MCZ,',
'    p_c010 => :ACS,',
'    p_c011 => :HAR,',
'    p_c012 => :MPL',
'    );',
'    */',
'    ',
'END;'))
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>36734136851719834
);
wwv_flow_imp.component_end;
end;
/
