prompt --application/shared_components/security/authentications/mitarbeiter_authentication
begin
--   Manifest
--     AUTHENTICATION: Mitarbeiter Authentication
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.0'
,p_default_workspace_id=>97227846552725811
,p_default_application_id=>102
,p_default_id_offset=>134035714542293292
,p_default_owner=>'SCHICHTPLANUNG'
);
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(127310876361923608)
,p_name=>'Mitarbeiter Authentication'
,p_scheme_type=>'NATIVE_CUSTOM'
,p_attribute_03=>'authenticate_user'
,p_attribute_05=>'N'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION authenticate_user(p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN',
'IS',
'    l_mitarbeiter_id Mitarbeiter.mitarbeiter_id%TYPE;',
'    l_password_hash Mitarbeiter.password_hash%TYPE;',
'    l_salt Mitarbeiter.salt%TYPE;',
'BEGIN',
'    SELECT mitarbeiter_id, password_hash, salt',
'    INTO l_mitarbeiter_id, l_password_hash, l_salt',
'    FROM Mitarbeiter',
'    WHERE (UPPER(email_adresse) = UPPER(p_username)',
'    OR UPPER(mitarbeiter_id) = UPPER(p_username))',
'    AND aktiv = ''Y'';',
'',
'    IF utility_pkg.generate_password_hash(p_password => p_password, p_salt => l_salt) = l_password_hash THEN',
'        :APP_USER := l_mitarbeiter_id;',
'        :SESSION_ID := APEX_CUSTOM_AUTH.GET_SESSION_ID;',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'        RETURN FALSE;',
'END authenticate_user;',
'',
'/*',
'function authenticate_user(p_username in varchar2, p_password in varchar2)',
'    return boolean',
'is',
'    l_mitarbeiter_id Mitarbeiter.mitarbeiter_id%type;',
'    l_stored_password_hash VARCHAR2(128);',
'    l_stored_salt VARCHAR2(32);',
'begin',
'    select mitarbeiter_id, password_hash, salt',
'    into l_mitarbeiter_id, l_stored_password_hash, l_stored_salt',
'    from Mitarbeiter',
'    where (upper(email_adresse) = upper(p_username)',
'    or upper(mitarbeiter_id) = upper(p_username))',
'    and aktiv = ''Y'';',
'',
'    if l_stored_password_hash = utility_pkg.generate_password_hash(p_password) then',
'        :APP_USER := l_mitarbeiter_id;',
'        return true;',
'    else',
'        return false;',
'    end if;',
'exception',
'    when no_data_found then',
'        return false;',
'end;',
'/*',
'function authenticate_user(p_username in varchar2, p_password in varchar2)',
'    return boolean',
'is',
'    l_mitarbeiter_id Mitarbeiter.mitarbeiter_id%type;',
'begin',
'    select mitarbeiter_id',
'    into :APP_USER',
'    from Mitarbeiter',
'    where (upper(email_adresse) = upper(p_username)',
'    or upper(mitarbeiter_id) = upper(p_username))',
'    and passwort = p_password',
'    and aktiv = ''Y'';',
'',
'    return true;',
'exception',
'    when no_data_found then',
'        return false;',
'end;*/'))
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
wwv_flow_imp.component_end;
end;
/
