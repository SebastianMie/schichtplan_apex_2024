prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 100
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(98789931738580436)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(98908746567580500)
,p_default_dialog_template=>wwv_flow_imp.id(98903941265580497)
,p_error_template=>wwv_flow_imp.id(98906248360580499)
,p_printer_friendly_template=>wwv_flow_imp.id(98908746567580500)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(98906248360580499)
,p_default_button_template=>wwv_flow_imp.id(98792702993580445)
,p_default_region_template=>wwv_flow_imp.id(98852972977580474)
,p_default_chart_template=>wwv_flow_imp.id(98852972977580474)
,p_default_form_template=>wwv_flow_imp.id(98852972977580474)
,p_default_reportr_template=>wwv_flow_imp.id(98852972977580474)
,p_default_tabform_template=>wwv_flow_imp.id(98852972977580474)
,p_default_wizard_template=>wwv_flow_imp.id(98852972977580474)
,p_default_menur_template=>wwv_flow_imp.id(98877814156580483)
,p_default_listr_template=>wwv_flow_imp.id(98852972977580474)
,p_default_irr_template=>wwv_flow_imp.id(98884152106580485)
,p_default_report_template=>wwv_flow_imp.id(98830315685580465)
,p_default_label_template=>wwv_flow_imp.id(98795537782580449)
,p_default_menu_template=>wwv_flow_imp.id(98791364244580444)
,p_default_calendar_template=>wwv_flow_imp.id(98791225786580443)
,p_default_list_template=>wwv_flow_imp.id(98811340777580456)
,p_default_nav_list_template=>wwv_flow_imp.id(98801539060580452)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(98801539060580452)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(98804962620580454)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(98882280679580484)
,p_default_dialogr_template=>wwv_flow_imp.id(98846167001580472)
,p_default_option_label=>wwv_flow_imp.id(98795537782580449)
,p_default_required_label=>wwv_flow_imp.id(98795428377580448)
,p_default_navbar_list_template=>wwv_flow_imp.id(98805390144580454)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/21.1/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
