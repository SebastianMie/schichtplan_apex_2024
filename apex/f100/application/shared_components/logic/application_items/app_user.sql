prompt --application/shared_components/logic/application_items/app_user
begin
--   Manifest
--     APPLICATION ITEM: APP_USER
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(127266988610381229)
,p_name=>'APP_USER'
,p_protection_level=>'N'
);
wwv_flow_imp.component_end;
end;
/
