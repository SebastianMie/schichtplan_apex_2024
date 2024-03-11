CREATE OR REPLACE EDITIONABLE PACKAGE BODY archiv_pkg AS

    PROCEDURE create_archiv_tables 
    AS
      v_start_year NUMBER := EXTRACT(YEAR FROM SYSDATE);
      v_start_half NUMBER := CASE WHEN EXTRACT(MONTH FROM SYSDATE) <= 6 THEN 1 ELSE 2 END;
      v_future_years NUMBER := 2;
      v_archiv_year NUMBER;
      v_archiv_half NUMBER;
      v_table_count NUMBER;
    BEGIN
      FOR i IN 1..v_future_years * 2 LOOP
        -- Berechnung des Jahres und Halbjahres für die Archivtabellen
        v_archiv_year := v_start_year + FLOOR(i / 2); -- Hochzählen des Jahres alle zwei Schleifeniterationen
        v_archiv_half := MOD(i, 2) + 1; -- Wechseln zwischen 1 und 2 für das Halbjahr
        
        -- Überprüfen, ob die Archivtabelle bereits existiert
        SELECT COUNT(*)
        INTO v_table_count
        FROM USER_TABLES
        WHERE TABLE_NAME = 'ARCHIV_PLANUNG_SCHICHTEN_' || v_archiv_year || '_' || v_archiv_half;
    
        IF v_table_count = 0 THEN
          -- Erstellen der Archivtabelle
          DECLARE
            v_sql VARCHAR2(1000);
          BEGIN
            v_sql := 'CREATE TABLE ARCHIV_PLANUNG_SCHICHTEN_' || v_archiv_year || '_' || v_archiv_half ||
                     ' AS (
                       SELECT *
                       FROM PLANUNG_SCHICHTEN
                       WHERE EXTRACT(YEAR FROM DATUM) = ' || v_archiv_year || '
                         AND (EXTRACT(MONTH FROM DATUM) <= 6 AND ' || v_archiv_half || ' = 1
                              OR EXTRACT(MONTH FROM DATUM) > 6 AND ' || v_archiv_half || ' = 2)
                     )';
    
            EXECUTE IMMEDIATE v_sql;
    
            -- Setze alle gefundenen Monate auf archiviert
            UPDATE MONAT_PLANUNG
            SET REF_STATUS_ID = 4
            WHERE MONAT_JAHR IN (
              SELECT TO_CHAR(DATUM, 'MON YYYY')
              FROM PLANUNG_SCHICHTEN
              WHERE EXTRACT(YEAR FROM DATUM) = v_archiv_year
                AND (EXTRACT(MONTH FROM DATUM) <= 6 AND v_archiv_half = 1
                     OR EXTRACT(MONTH FROM DATUM) > 6 AND v_archiv_half = 2)
            );
    
            DBMS_OUTPUT.PUT_LINE('Archivtabelle ARCHIV_PLANUNG_SCHICHTEN_' || v_archiv_year || '_' || v_archiv_half ||
                                 ' erfolgreich erstellt.');
          END;
        ELSE
          DBMS_OUTPUT.PUT_LINE('Archivtabelle ARCHIV_PLANUNG_SCHICHTEN_' || v_archiv_year || '_' || v_archiv_half ||
                               ' existiert bereits.');
        END IF;
      END LOOP;
    END create_archiv_tables;

    
    PROCEDURE archive_data(p_monat IN VARCHAR2) AS
    v_archiv_start_date DATE;
    v_archiv_end_date DATE;
    BEGIN
    -- Extrahieren des Start- und Enddatums des angegebenen Monats
    v_archiv_start_date := TO_DATE(p_monat || ' 01', 'MON YYYY DD');
    v_archiv_end_date := LAST_DAY(v_archiv_start_date);

    -- Löschen der archivierten Datensätze aus der Tabelle PLANUNG_SCHICHTEN
    DELETE FROM PLANUNG_SCHICHTEN
    WHERE DATUM BETWEEN v_archiv_start_date AND v_archiv_end_date;

    -- Optional: Ausgabe der Anzahl der gelöschten Datensätze
    DBMS_OUTPUT.PUT_LINE('Es wurden ' || SQL%ROWCOUNT || ' Datensätze aus der Tabelle PLANUNG_SCHICHTEN gelöscht.');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Fehler beim Löschen der Datensätze: ' || SQLERRM);
    END archive_data;

    PROCEDURE recover_data(p_monat IN VARCHAR2) AS
    v_archiv_table_name VARCHAR2(100);
    v_archiv_start_date DATE;
    v_archiv_end_date DATE;
    v_sql VARCHAR2(1000);
    BEGIN
    -- Identifizieren der entsprechenden Archivtabelle für den angegebenen Monat
    v_archiv_table_name := 'ARCHIV_PLANUNG_SCHICHTEN_' || EXTRACT(YEAR FROM TO_DATE(p_monat, 'MON YYYY'))
        || '_' || CASE WHEN EXTRACT(MONTH FROM TO_DATE(p_monat, 'MON YYYY')) <= 6 THEN 1 ELSE 2 END;

    -- Überprüfen, ob die Archivtabelle existiert
    DECLARE
        v_table_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_table_count
        FROM USER_TABLES
        WHERE TABLE_NAME = v_archiv_table_name;

        IF v_table_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Die Archivtabelle ' || v_archiv_table_name || ' existiert nicht.');
            RETURN; -- Beenden der Prozedur, wenn die Archivtabelle nicht vorhanden ist
        END IF;
    END;

    -- Extrahieren des Start- und Enddatums des angegebenen Monats
    v_archiv_start_date := TO_DATE(p_monat || ' 01', 'MON YYYY DD');
    v_archiv_end_date := LAST_DAY(v_archiv_start_date);

    -- Dynamisches SQL-Statement vorbereiten
    v_sql := 'INSERT INTO PLANUNG_SCHICHTEN SELECT * FROM ' || v_archiv_table_name ||
             ' WHERE DATUM BETWEEN :start_date AND :end_date';

    -- Daten aus der Archivtabelle in die Tabelle PLANUNG_SCHICHTEN zurückkopieren
    EXECUTE IMMEDIATE v_sql USING v_archiv_start_date, v_archiv_end_date;


    -- Optional: Ausgabe der Anzahl der zurückkopierten Datensätze
    DBMS_OUTPUT.PUT_LINE('Es wurden ' || SQL%ROWCOUNT || ' Datensätze aus der Archivtabelle ' || v_archiv_table_name || ' in die Tabelle PLANUNG_SCHICHTEN zurückkopiert.');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Fehler beim Zurückkopieren der Daten: ' || SQLERRM);
    END;

END ARCHIV_PKG;
/