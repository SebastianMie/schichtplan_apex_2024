CREATE OR REPLACE EDITIONABLE PACKAGE BODY constraints_pkg as

    procedure pruefe_constraints_ma(
        p_mitarbeiter_id in varchar2,
        p_monat in date
    )
    as
        l_curr_datum meldungen_mitarbeiter.datum%type;
        l_curr_endzeit planung_schichten.endzeit%type;
        l_curr_meldung_id meldungen_mitarbeiter.meldung_id%type;
        l_prev_datum planung_schichten.datum%type;
        l_prev_endzeit planung_schichten.endzeit%type;
        l_prev_startzeit planung_schichten.startzeit%type;
        l_diff_hours number;
        l_pause_startzeit planung_schichten.endzeit%type;
        l_pause_endzeit planung_schichten.startzeit%type;
    begin
        -- Löschen alte Meldungen für den Mitarbeiter
        delete from meldungen_mitarbeiter where mitarbeiter_id = p_mitarbeiter_id and trunc(datum, 'MM') = trunc(p_monat, 'MM');

        for curr_schicht in (
            select datum, mitarbeiter_id, vorgabe_code_id, startzeit, endzeit
            from planung_schichten
            where mitarbeiter_id = p_mitarbeiter_id
            and trunc(datum, 'MM') = trunc(p_monat, 'MM') -- Filtern nach dem angegebenen Monat
            and vorgabe_code_id is not null
            order by datum
        ) loop
            -- Prüfen, ob mindestens 11 Stunden Abstand zwischen den Schichten liegen
            if l_prev_endzeit is not null then
                l_diff_hours := round((curr_schicht.startzeit - l_prev_endzeit) * 24);
                if l_diff_hours <= 10 then
                    dbms_output.put_line(l_diff_hours);
                    insert_meldungen_mitarbeiter(1, p_mitarbeiter_id, curr_schicht.datum);
                end if;
            end if;
            -- Aktualisiere die vorherige Schichtinformationen
            l_prev_datum := curr_schicht.datum;
            l_prev_endzeit := curr_schicht.endzeit;

            -- Setze die Startzeit der Pause
            l_pause_startzeit := curr_schicht.endzeit;
        end loop;

        --weitere constraint Prüfungen
        pruefe_constraint_35_h(p_mitarbeiter_id, p_monat);
        pruefe_constraint_urlaub_we(p_mitarbeiter_id, p_monat);
    end pruefe_constraints_ma;

    procedure pruefe_constraint_35_h (
        p_mitarbeiter_id in varchar2,
        p_monat in date
    )
    as
        l_curr_datum meldungen_mitarbeiter.datum%type;
        l_curr_endzeit planung_schichten.endzeit%type;
        l_curr_meldung_id meldungen_mitarbeiter.meldung_id%type;
        l_diff_hours number;
        l_pause_startzeit planung_schichten.endzeit%type;
        l_erste_schicht planung_schichten.startzeit%type;
        l_pause_35_count number := 0; -- Anzahl 35h Pausen im Monat
        l_total_pause_duration number := 0; -- Pause-Dauer in Stunden
        l_last_day number;
        l_month_start date;
        l_month_end date;
        l_month_middle date;
    begin
        -- Berechnung der Monatsgrenzen
        l_month_start := trunc(p_monat, 'MONTH');
        l_month_end := last_day(p_monat);
        l_month_middle := l_month_start + ((l_month_end - l_month_start) / 2);

        -- Prüfen der Pausendauer zwischen Monatsstart und dem ersten Termin in erster Monatshälfte
        select min(startzeit), max(endzeit)
        into l_erste_schicht, l_pause_startzeit
        from planung_schichten
        where mitarbeiter_id = p_mitarbeiter_id
        and vorgabe_code_id is not null
        and datum >= l_month_start
        and datum < l_month_middle;

        -- Fall kein Termin in 1. Monatshälfte
        if l_pause_startzeit is null then
            l_pause_35_count := l_pause_35_count + 1;
        else
            l_diff_hours := round((l_month_middle - l_pause_startzeit) * 24); --Pause monatsmitte - spätester endzeitpunkt
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
                l_diff_hours := round((l_erste_schicht - l_month_start) * 24); --Pause frühester startzeitpunkt - monatsstart
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
        end if;

        l_pause_startzeit := l_month_start; -- Setzen Sie die Pause-Startzeit auf den Monatsstart
        -- Loop für die erste Hälfte des Monats (1. und 2. Woche)
        for curr_schicht in (
            select datum, mitarbeiter_id, vorgabe_code_id, startzeit, endzeit
            from planung_schichten
            where mitarbeiter_id = p_mitarbeiter_id
            and vorgabe_code_id is not null
            and datum >= l_month_start
            and datum < l_month_middle -- Einschränkung auf die erste Hälfte des Monats
            order by datum
        ) loop
            if curr_schicht.startzeit is not null or curr_schicht.endzeit is not null then 
            -- Prüfen 35h Pausen innerhalb der ersten Wochen
            l_diff_hours := round((curr_schicht.startzeit - l_pause_startzeit) * 24);
            l_total_pause_duration := l_total_pause_duration + l_diff_hours;
            l_pause_startzeit := curr_schicht.endzeit;
            end if;
            dbms_output.put_line('Curr Schicht: '|| curr_schicht.datum || ' ' || to_char(curr_schicht.startzeit, 'DD.MM HH24:MI') || ' ' || to_char(curr_schicht.endzeit, 'DD.MM HH24:MI'));
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
        end loop;

        -- Überprüfung der ersten Hälfte des Monats
        if l_pause_35_count = 0 then
            insert_meldungen_mitarbeiter(3, p_mitarbeiter_id, p_monat);
        end if;

        -- Reset der Pause-Zählung und Pausenvariablen
        l_pause_35_count := 0;
        l_total_pause_duration := 0;
        l_pause_startzeit := null;

        -- Loop für die zweite Hälfte des Monats (3. und 4. Woche)
        for curr_schicht in (
            select datum, mitarbeiter_id, vorgabe_code_id, startzeit, endzeit
            from planung_schichten
            where mitarbeiter_id = p_mitarbeiter_id
            and vorgabe_code_id is not null
            and datum >= l_month_middle
            and datum <= l_month_end -- Einschränkung auf die zweite Hälfte des Monats
            order by datum
        ) loop
        if curr_schicht.startzeit is not null or curr_schicht.endzeit is not null then
            -- Prüfen 35h Pausen innerhalb der zweiten Wochen
            l_diff_hours := round((curr_schicht.startzeit - l_pause_startzeit) * 24);
            -- Aktualisiere die vorherige Schichtinformationen
            l_pause_startzeit := curr_schicht.endzeit;
            end if;
            dbms_output.put_line('Curr Schicht: '|| curr_schicht.datum || ' ' || to_char(curr_schicht.startzeit, 'DD.MM HH24:MI') || ' ' || to_char(curr_schicht.endzeit, 'DD.MM HH24:MI'));
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
        end loop;

       -- Prüfen der Pausendauer zwischen Monatsmitte und dem ersten Termin in zweiter Monats Hälfte
        select max(endzeit), min(startzeit)
        into l_pause_startzeit, l_erste_schicht
        from planung_schichten
        where mitarbeiter_id = p_mitarbeiter_id
        and vorgabe_code_id is not null
        and datum <= l_month_end
        and datum > l_month_middle;

        -- Fall kein Termin in 2. Monatshälfte
        if l_pause_startzeit is null then
            l_diff_hours := round((l_month_end - l_month_middle) * 24);
            l_pause_35_count := l_pause_35_count + 1;
        else
            l_diff_hours := round((l_month_end - l_pause_startzeit) * 24); 
            dbms_output.put_line('PAusendauer: '|| l_diff_hours || ' ' || to_char(l_month_end, 'DD.MM HH24:MI') || ' - ' || to_char(l_pause_startzeit, 'DD.MM HH24:MI'));
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
            l_diff_hours := round((l_erste_schicht - l_month_middle) * 24); 
            if l_diff_hours >= 35 then
                l_pause_35_count := l_pause_35_count + 1;
            end if;
        end if;

        -- Überprüfung der zweiten Hälfte des Monats
        if l_pause_35_count = 0 then
            insert_meldungen_mitarbeiter(4, p_mitarbeiter_id, p_monat);
        end if;
    end pruefe_constraint_35_h;

    procedure pruefe_constraint_urlaub_we(
        p_mitarbeiter_id in varchar2,
        p_monat in date
    ) as
        l_curr_datum planung_schichten.datum%type;
        l_curr_vorgabe_code_id planung_schichten.vorgabe_code_id%type;
        c_urlaub_constant varchar2(20) := 'urlaub';
    begin
        for curr_schicht in (
            select datum, vorgabe_code_id
            from planung_schichten
            where mitarbeiter_id = p_mitarbeiter_id
            and trunc(datum, 'MM') = trunc(p_monat, 'MM') -- Filtern nach dem angegebenen Monat
            and to_char(datum, 'DY', 'NLS_DATE_LANGUAGE = GERMAN') in ('SA', 'SO') -- Wochenendtage sind Samstag und Sonntag
            order by datum
        ) loop
            -- Überprüfen, ob der vorgabe_code_id 'urlaub' für das Wochenende festgelegt ist
            if curr_schicht.vorgabe_code_id = c_urlaub_constant then
                insert_meldungen_mitarbeiter(5, p_mitarbeiter_id, curr_schicht.datum); -- Angenommen, dass der Fehlercode 5 für diesen Fehler reserviert ist
            end if;
        end loop;
    end pruefe_constraint_urlaub_we;

    procedure insert_meldungen_mitarbeiter(
        p_meldung_id in number,
        p_mitarbeiter_id in varchar2,
        p_datum in date
    ) as
    begin
        -- Führe das Einfügen der Datensätze in die Tabelle Meldungen_Mitarbeiter durch
        insert into meldungen_mitarbeiter (meldungen_mitarbeiter_id, meldung_id, mitarbeiter_id, datum)
        values (meldungen_mitarbeiter_seq.nextval, p_meldung_id, p_mitarbeiter_id, p_datum);
    end insert_meldungen_mitarbeiter;

end constraints_pkg;
/