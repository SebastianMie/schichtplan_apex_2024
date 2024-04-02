prompt --application/shared_components/logic/application_items/session_id
begin
--   Manifest
--     APPLICATION ITEM: SESSION_ID
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
 p_id=>wwv_flow_imp.id(116567351611691886)
,p_name=>'SESSION_ID'
,p_protection_level=>'I'
);
wwv_flow_imp.component_end;
end;
/
