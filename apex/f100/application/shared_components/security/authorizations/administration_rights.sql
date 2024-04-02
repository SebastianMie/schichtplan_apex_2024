prompt --application/shared_components/security/authorizations/administration_rights
begin
--   Manifest
--     SECURITY SCHEME: Administration Rights
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(98765686575580400)
,p_name=>'Administration Rights'
,p_scheme_type=>'NATIVE_FUNCTION_BODY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_rolle_id VARCHAR2(100);',
'BEGIN',
'  SELECT rolle_id INTO l_rolle_id',
'  FROM mitarbeiter',
'  WHERE mitarbeiter_id = :APP_USER;',
'  ',
unistr('  -- Beispiel: Autorisierung f\00FCr Mitarbeiter mit der Rolle ''MA'''),
'  IF l_rolle_id = ''ADM'' THEN',
'    RETURN TRUE;',
'  END IF;',
'',
'  IF l_rolle_id = ''MA'' THEN',
'    RETURN FALSE;',
'  END IF;',
'  ',
'  RETURN FALSE;',
'END;'))
,p_error_message=>'Insufficient privileges, user is not an Administrator'
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
