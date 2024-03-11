CREATE OR REPLACE EDITIONABLE PACKAGE BODY utility_pkg as 

    procedure generate_dates_for_ma(
        p_datum_bis in date
    )
    as
       p_datum_von date := trunc(sysdate); -- Initialisiere p_datum_von mit dem aktuellen Datum
      p_anzahl_tage number;
      p_eintrag_vorhanden number := 0;
    begin

      p_anzahl_tage :=  trunc(p_datum_bis) - trunc(p_datum_von);

      --loop für Anzahl Tage
      for i in 0..p_anzahl_tage
      loop
        -- innere loop für alle Mitarbeiter ids
        for r_row in (
          select ma.mitarbeiter_id 
          from mitarbeiter ma 
          where ma.service_team_id = 1
          and ma.rolle_id = 'MA'
        )
        loop
          --pruefen ob bereits ein Eintrag vorhanden
          select count(1) into p_eintrag_vorhanden 
          from planung_schichten 
          where datum = p_datum_von + i 
          and mitarbeiter_id = r_row.mitarbeiter_id;

          --dbms_output.put_line(r_row.mitarbeiter_id);

          if (p_eintrag_vorhanden = 0) then
            -- insert Datum und Mitarbeiter
            insert into planung_schichten (datum, wochentag, mitarbeiter_id, vorgabe_code_id) 
            values (p_datum_von + i, to_char(p_datum_von + i,'Dy'), r_row.mitarbeiter_id,'');
            --dbms_output.put_line(r_row.mitarbeiter_id);
            --dbms_output.put_line(p_datum_von + i);
          end if;
        end loop;
      end loop;
    end generate_dates_for_ma;

    procedure insert_rows_land_monat_limit as
    begin
       for monat_rec in (select distinct monat_planung_id from monat_planung)
       loop
          for land_rec in (select land_id from land)
          loop
             declare
                v_count number;
             begin
                select count(*)
                into v_count
                from land_monat_limit
                where monat_planung_id = monat_rec.monat_planung_id
                  and land_id = land_rec.land_id;

                if v_count = 0 then
                   insert into land_monat_limit (land_monat_limit_id, monat_planung_id, land_id, limit_h)
                   values (land_monat_limit_seq.nextval, monat_rec.monat_planung_id, land_rec.land_id, null);
                end if;
             end;
          end loop;
       end loop;
       commit;
    exception
       when others then
          rollback;
          raise;
    end insert_rows_land_monat_limit;

    procedure insert_comments_for_all_days 
    as
      monat date;
    begin
      for monat_rec in (select distinct monat_jahr from monat_planung)
      loop
        monat := to_date(monat_rec.monat_jahr, 'mon yyyy');
        for d in 1..extract(day from last_day(monat))
        loop
          declare
            v_count number;
          begin
            select count(*)
            into v_count
            from kommentar
            where datum = to_date(to_char(monat, 'mon yyyy') || '-' || d, 'mon yyyy-dd');

            if v_count = 0 then
              insert into kommentar (kommentar_id, datum, mitarbeiter_id, kommentar)
              values (kommentar_seq.nextval,to_date(to_char(monat, 'mon yyyy') || '-' || d, 'mon yyyy-dd'), null, null);
            end if;
          end;
        end loop;
      end loop;
      commit;
    exception
      when others then
        rollback;
        raise;
    end insert_comments_for_all_days;


    procedure update_planung_schichten_zeitraum
    as
      v_vorgabe_code_id planung_schichten.vorgabe_code_id%type;
      v_startzeit_h vorgabe_codes.startzeit_h%type;
      v_endzeit_h vorgabe_codes.endzeit_h%type;
      v_startzeit planung_schichten.startzeit%type;
      v_endzeit planung_schichten.endzeit%type;
    begin
      for v_rec in (
        select distinct p.planung_schichten_id, p.datum, p.startzeit, p.endzeit, v.vorgabe_code_id, v.startzeit_h, v.endzeit_h
        from planung_schichten p 
        join vorgabe_codes v on v.vorgabe_code_id = p.vorgabe_code_id
        where p.vorgabe_code_id is not null
      )
      loop
        v_startzeit := v_rec.datum + v_rec.startzeit_h/24;
        -- prüfen ob Schicht in den Nächten Tag geht
        if v_rec.startzeit_h > v_rec.endzeit_h then
          v_endzeit := (v_rec.datum+1) + v_rec.endzeit_h/24;
        else
          v_endzeit := v_rec.datum + v_rec.endzeit_h/24;
        end if;

        update planung_schichten
        set startzeit = v_startzeit, 
            endzeit = v_endzeit
        where planung_schichten_id =  v_rec.planung_schichten_id 
        and vorgabe_code_id = v_rec.vorgabe_code_id 
        and v_rec.vorgabe_code_id is not null;
      end loop;
    end update_planung_schichten_zeitraum;

    procedure update_password_hash(
      p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type,
      p_password in varchar2,
      p_confirm_password in varchar2
    )
    is
      l_salt varchar2(32) := null;
      l_password_hash varchar2(128) := null;
    begin
      if p_password = p_confirm_password then
        l_salt := substr(dbms_random.string('A', 32), 1, 32);
        l_password_hash := generate_password_hash(p_password, l_salt);
        update mitarbeiter
        set password_hash = l_password_hash,
            salt = l_salt
        where mitarbeiter_id = p_mitarbeiter_id;
      else
        -- Handle error if passwords don't match
        raise_application_error(-20001, 'Passwords do not match');
      end if;
    end update_password_hash;

    function generate_password_hash (
      p_password in varchar2,
      p_salt in varchar2
    ) return varchar2
    is
      l_hash varchar2(64);
    begin
      l_hash := dbms_obfuscation_toolkit.md5(input_string => p_password || p_salt);
      return p_salt || l_hash;
    exception
      when others then
        raise_application_error(-20001, 'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    end generate_password_hash;

    procedure init_and_update_password_hashes
    is
      l_salt varchar2(32);
    begin
      for mitarbeiter_rec in (
        select mitarbeiter_id 
        from mitarbeiter 
        where password_hash is null 
        and salt is null
      )
      loop
        l_salt := substr(dbms_random.string('A', 32), 1, 32);
        update Mitarbeiter
        set password_hash = generate_password_hash(mitarbeiter_rec.mitarbeiter_id, l_salt),
            salt = l_salt
        where mitarbeiter_id = mitarbeiter_rec.mitarbeiter_id;
      end loop;
    end init_and_update_password_hashes;

    function get_status(p_month varchar2)
      return varchar2
    is
      l_bezeichnung varchar2(2000);
      l_monat date;
    begin
      l_monat := to_date(p_month, 'MON YYYY');
      select rs.bezeichnung
      into l_bezeichnung
      from ref_status rs
      join monat_planung mp on mp.ref_status_id = rs.ref_status_id
      where trunc(to_date(mp.monat_jahr, 'MON YYYY'),'MM') = trunc(l_monat, 'MM');

      return l_bezeichnung;
    exception
      when no_data_found then
        return 'Keine Daten für den ausgewählten Monat gefunden';
    end get_status;

    function get_monat_ma_sum_h (
      p_datum in date,
      p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type
    ) return number
    is
      l_ma_land varchar2(20);
      l_sum_ma_h number := 0;
      l_sum_ueberschneidung number := 0;
      l_sum_ueberschneidung_curr_month number := 0;
      l_monat_start date;
      l_monat_end date;
    begin
      l_monat_start := trunc(p_datum, 'MM');
      l_monat_end := last_day(p_datum);

      select land_id into l_ma_land
      from mitarbeiter
      where mitarbeiter_id = p_mitarbeiter_id;

      if l_ma_land is not null then
        if l_ma_land != 'PL' then
          select sum((ps.endzeit - ps.startzeit) * 24)
          into l_sum_ma_h
          from planung_schichten ps
          where ps.mitarbeiter_id = p_mitarbeiter_id
          and ps.datum >= l_monat_start
          and ps.datum <= l_monat_end;

          -- Addieren von Monatsüberschneidung aus letztem Monat
          select (max(endzeit) - trunc(last_day(p_datum - 1) + 1)) * 24 as diff_hours
          into l_sum_ueberschneidung
          from planung_schichten ps
          where mitarbeiter_id = p_mitarbeiter_id
          and ps.datum = last_day(p_datum - 1);

          if l_sum_ueberschneidung > 0 then
            l_sum_ma_h := l_sum_ma_h + l_sum_ueberschneidung;
          end if;

          --subtrahieren von Monatsüberschneidung aktueller Monat
          select (max(endzeit) - trunc(last_day(p_datum) + 1)) * 24 as diff_hours
          into l_sum_ueberschneidung_curr_month
          from planung_schichten ps
          where mitarbeiter_id = p_mitarbeiter_id
          and ps.datum = last_day(p_datum);

          if l_sum_ueberschneidung_curr_month > 0 and l_sum_ueberschneidung_curr_month is not null then
            l_sum_ma_h := l_sum_ma_h - l_sum_ueberschneidung_curr_month;
          end if;
        else
          select sum((ps.endzeit - ps.startzeit) * 24)
          into l_sum_ma_h
          from planung_schichten ps
          where ps.mitarbeiter_id = p_mitarbeiter_id
          and ps.datum >= l_monat_start
          and ps.datum <= l_monat_end;
        end if;
      end if;

      if l_sum_ma_h is not null then
        return l_sum_ma_h;
      else
        return case when l_sum_ueberschneidung > 0 then l_sum_ueberschneidung else 0 end;
      end if;
    exception
      when no_data_found then
        return l_sum_ma_h; 
    end get_monat_ma_sum_h;

    function user_adm_authorization (
      p_user_id varchar2
    ) return boolean
    is
      l_rolle_id varchar2(100);
    begin
      select rolle_id into l_rolle_id
      from mitarbeiter
      where mitarbeiter_id = p_user_id;

      -- Beispiel: Autorisierung für Mitarbeiter mit der Rolle 'MA'
      if l_rolle_id = 'ADM' then
        return true;
      end if;

      if l_rolle_id = 'MA' then
        return false;
      end if;

      return false;
    end user_adm_authorization;

    function save_matrix_mitarbeiter (
      p_datum in date,
      p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type,
      p_vorgabe_code_id in varchar2
    ) return varchar2
    is
      v_startzeit_h vorgabe_codes.startzeit_h%type;
      v_endzeit_h vorgabe_codes.endzeit_h%type;
      v_startzeit planung_schichten.startzeit%type;
      v_endzeit planung_schichten.endzeit%type;
      v_vorgabe_code_exists number;
    begin
      -- Überprüfen, ob vorgabe_code_id ein gültiger Wert ist
      select count(*) into v_vorgabe_code_exists
      from vorgabe_codes
      where vorgabe_code_id = p_vorgabe_code_id;

      if v_vorgabe_code_exists = 1 then
        -- start und endzeit in ganzen Std. für vorgabe_code_id holen
        select startzeit_h, endzeit_h
        into v_startzeit_h, v_endzeit_h
        from vorgabe_codes
        where vorgabe_code_id = p_vorgabe_code_id;

        --IF v_startzeit_h IS NOT NULL AND v_endzeit_h IS NOT NULL THEN
        v_startzeit := p_datum + v_startzeit_h/24;
        -- Prüfen, ob Schicht in den nächsten Tag geht
        if v_startzeit_h > v_endzeit_h then
          v_endzeit := (p_datum + 1) + v_endzeit_h/24;
        else
          v_endzeit := p_datum + v_endzeit_h/24;
        end if;

        -- Zelle updaten
        update planung_schichten
        set vorgabe_code_id = p_vorgabe_code_id,
            startzeit = v_startzeit,
            endzeit = v_endzeit
        where datum = p_datum
        and mitarbeiter_id = p_mitarbeiter_id;

        return 'true';
        --END IF;
      end if;
      -- schicht gelöscht
      if p_vorgabe_code_id = '' or p_vorgabe_code_id is null then
        update planung_schichten set
        vorgabe_code_id = p_vorgabe_code_id,
        startzeit = null,
        endzeit = null
        where datum = p_datum
        and mitarbeiter_id = p_mitarbeiter_id;

        return 'true';
      else
        -- vorgabe_code_id existiert nicht
        return 'false';
      end if;
    end save_matrix_mitarbeiter;
    
    function save_matrix_mitarbeiter (
        p_matrix_data IN matrix_table_type
    ) return VARCHAR2
    IS
        v_startzeit_h vorgabe_codes.startzeit_h%TYPE;
        v_endzeit_h vorgabe_codes.endzeit_h%TYPE;
        v_startzeit planung_schichten.startzeit%TYPE;
        v_endzeit planung_schichten.endzeit%TYPE;
        v_vorgabe_code_exists NUMBER;
        v_missing_entries VARCHAR2(4000) := '['; -- Initialisieren Sie den Text für fehlende Einträge mit eckiger Klammer
    BEGIN
        
        -- Durchlaufen des Arrays und Verarbeiten der Daten
        FOR i IN 1..p_matrix_data.COUNT LOOP
            -- Überprüfen, ob vorgabe_code_id ein gültiger Wert ist
            SELECT COUNT(*)
            INTO v_vorgabe_code_exists
            FROM vorgabe_codes
            WHERE vorgabe_code_id = p_matrix_data(i).vorgabe_code_id;
    
            IF v_vorgabe_code_exists = 1 THEN
                -- Start- und Endzeit für vorgabe_code_id holen
                SELECT startzeit_h, endzeit_h
                INTO v_startzeit_h, v_endzeit_h
                FROM vorgabe_codes
                WHERE vorgabe_code_id = p_matrix_data(i).vorgabe_code_id;
    
                -- Startzeit berechnen
                v_startzeit := p_matrix_data(i).datum + v_startzeit_h/24;
    
                -- Endzeit berechnen
                IF v_startzeit_h > v_endzeit_h THEN
                    v_endzeit := (p_matrix_data(i).datum + 1) + v_endzeit_h/24;
                ELSE
                    v_endzeit := p_matrix_data(i).datum + v_endzeit_h/24;
                END IF;
    
                -- Zelle aktualisieren
                UPDATE planung_schichten
                SET vorgabe_code_id = p_matrix_data(i).vorgabe_code_id,
                    startzeit = v_startzeit,
                    endzeit = v_endzeit
                WHERE datum = p_matrix_data(i).datum
                AND mitarbeiter_id = p_matrix_data(i).mitarbeiter_id;
            ELSE
                apex_debug.message('Entry-Missing %s %s %s', 'Datum: ' || TO_CHAR(p_matrix_data(i).datum) || ', Mitarbeiter ID: ' || p_matrix_data(i).mitarbeiter_id || ', Vorgabe Code ID: ' || p_matrix_data(i).vorgabe_code_id);
                -- Schicht löschen, wenn Vorgabecode nicht existiert
                IF p_matrix_data(i).vorgabe_code_id is not null then
                    -- Fehlenden Eintrag zur Auflistung hinzufügen
                    v_missing_entries := v_missing_entries || '{"Datum":"' || TO_CHAR(p_matrix_data(i).datum) || '","Mitarbeiter ID":"' || p_matrix_data(i).mitarbeiter_id || '","Vorgabe Code ID":"' || p_matrix_data(i).vorgabe_code_id || '"}, '; 
                ELSE
                    UPDATE planung_schichten
                    SET vorgabe_code_id = null,
                        startzeit = null,
                        endzeit = null
                    WHERE datum = p_matrix_data(i).datum
                    AND mitarbeiter_id = p_matrix_data(i).mitarbeiter_id;
                END IF;
            END IF;
        END LOOP;
        
        -- Abschluss der eckigen Klammer für das JSON-Array
        v_missing_entries := v_missing_entries || ']';
        
        -- Rückgabe des Strings für die fehlenden Einträge
        return v_missing_entries;
    END save_matrix_mitarbeiter;


    procedure generate_future_months 
    is
      v_current_month date := trunc(sysdate, 'MM');
      v_target_month date := add_months(sysdate, 72); -- 3 Jahre in die Zukunft
      v_count number;
    begin
      while v_current_month <= v_target_month loop
        -- Prüfen, ob der Monat-Jahr Datensatz bereits existiert
        select count(*) into v_count
        from monat_planung
        where monat_jahr = to_char(v_current_month, 'MON YYYY'); 

        -- Wenn nicht, dann Datensatz einfügen
        if v_count = 0 then
          insert into monat_planung (monat_jahr, ref_status_id)
          values (to_char(v_current_month, 'MON YYYY'), 1);
        end if;

        -- Gehe zum nächsten Monat
        v_current_month := add_months(v_current_month, 1);
      end loop;

      commit;

    exception
      when others then
        rollback;
        raise;
    end generate_future_months;
    
    FUNCTION get_last_sperre_info (
      p_app_user in VARCHAR2
    )RETURN VARCHAR2 
    IS
        v_last_sperre_info VARCHAR2(100);
        p_gesperrt_bis DATE;
    BEGIN
        SELECT 'Die Bearbeitung der Seite ist gesperrt von ' || MITARBEITER_ID || ' bis ' || TO_CHAR(GESPERRT_BIS, 'DD.MM.YYYY HH24:MI') 
        INTO v_last_sperre_info
        FROM MITARBEITER_SEITE_SPERRE
        WHERE ROWNUM = 1
        ORDER BY GESPERRT_BIS DESC;
        --WHERE GESPERRT_BIS < SYSDATE + (20 / (24 * 60));

        RETURN v_last_sperre_info;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        -- Wenn kein Eintrag gefunden wurde, füge einen neuen Eintrag hinzu
        p_gesperrt_bis := SYSDATE + (20 / (24 * 60)); -- 20 Minuten in Tagen umrechnen
        INSERT INTO MITARBEITER_SEITE_SPERRE (MITARBEITER_ID, GESPERRT_BIS)
        VALUES (p_app_user, p_gesperrt_bis);
        commit;
        v_last_sperre_info := 'Die Bearbeitung der Seite ist gesperrt von ' || p_app_user || ' bis ' || TO_CHAR(p_gesperrt_bis, 'DD.MM.YYYY HH24:MI');
        --Scheduler starten nach 20 minuten wieder DS löscht
        --DBMS_SCHEDULER.run_job('DELETE_SITE_LOCKED_ENTRIES');
        DBMS_SCHEDULER.disable('DELETE_SITE_LOCKED_ENTRIES');
        DBMS_SCHEDULER.enable('DELETE_SITE_LOCKED_ENTRIES');
        return v_last_sperre_info;
    END get_last_sperre_info;
    
    FUNCTION get_last_sperre_ma 
    RETURN VARCHAR2 IS
        v_last_sperre_ma VARCHAR2(100);
    BEGIN
        SELECT MITARBEITER_ID 
        INTO v_last_sperre_ma
        FROM MITARBEITER_SEITE_SPERRE
        WHERE ROWNUM = 1
        ORDER BY GESPERRT_BIS DESC;

        RETURN v_last_sperre_ma;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN 'Keine Sperre gefunden';
    END get_last_sperre_ma;


end utility_pkg;
/