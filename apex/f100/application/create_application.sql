prompt --application/create_application
begin
--   Manifest
--     FLOW: 100
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'SCHICHTPLANUNG')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Schichtpanungstool')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'SCHICHTPANUNGSTOOL')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'F7C888FA36F4017E3B506B2791CB525E798866D2F17C7F93628967B72426C6D2'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'19.2'
,p_session_state_commits=>'IMMEDIATE'
,p_flow_language=>'de'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_allow_feedback_yn=>'Y'
,p_date_format=>'DS'
,p_timestamp_format=>'DS'
,p_timestamp_tz_format=>'DS'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>'Application created from create application wizard 2023.01.12.'
,p_authentication_id=>wwv_flow_imp.id(127310876361923608)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'Schichtplanungstool'
,p_app_builder_icon_name=>'app-icon.svg'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<span /><title>Site Maintenance</title>',
'<style>',
'  body { text-align: center; padding: 20px; }',
'  @media (min-width: 768px){',
'    body{ padding-top: 200px; }',
'  }',
'  h1 { font-size: 50px; }',
'  body { font: 20px Helvetica, sans-serif; color: #333; }',
'  article { display: block; text-align: left; max-width: 650px; margin: 0 auto; }',
'  a { color: #dc8100; text-decoration: none; }',
'  a:hover { color: #333; text-decoration: none; }',
'</style>',
'',
'<article>',
'    <h1>We&rsquo;ll be back soon!</h1>',
'    <div>',
'        <p>Sorry for the inconvenience but we&rsquo;re performing some maintenance at the moment. We&rsquo;ll be back online shortly!</p>',
'        <p>&mdash; The Team</p>',
'    </div>',
'</article>'))
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_pass_ecid=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'N'
,p_tokenize_row_search=>'N'
,p_friendly_url=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'Schichtplanungstool'
,p_last_updated_by=>'SEM'
,p_last_upd_yyyymmddhh24miss=>'20240228085622'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>3
,p_print_server_type=>'NATIVE'
,p_is_pwa=>'N'
);
wwv_flow_imp.component_end;
end;
/
