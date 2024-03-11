CREATE OR REPLACE EDITIONABLE PACKAGE BODY archiv_planung_schichten_matrix_pkg as

  -- Diese Prozedur gibt uns die Namen für die Spalten
  function describe (
     p_table         in out dbms_tf.table_t
   , p_object_hash   raw
  ) return dbms_tf.describe_t
  is
    l_cols dbms_tf.columns_new_t;
    l_counter number := 1;
  begin
    -- Diese Spalten sollen weiter processed werden, wenn Fetch Rows aufgerufen wird
    -- Wir nehmen hier einfach alle, natürlich könnte man auch nur nach Relevanten(ID z.B. Filtern)
    for i in 1 .. p_table.column.count loop
       p_table.column(i).pass_through := true;
       p_table.column(i).for_read     := true;
    end loop;
    --
    for mitarbeiter in(
            -- Wir gehen hier von einer Tabelle Roles aus, in der die Möglichkeit aller Rollen gespeichert ist.
      select  mitarbeiter_id
      from mitarbeiter
    )
    loop
      l_cols(l_counter) := dbms_tf.column_metadata_t (
        name     => upper(mitarbeiter.mitarbeiter_id),    -- Hier müssen wir noch auf Probleme Aufpassen wie Leerzeich oder Minus im Spaltennamen
        type     => dbms_tf.type_varchar2,  -- Könnte hier auch 
        name_len => length(mitarbeiter.mitarbeiter_id)    -- Nehmen hier einfach die Länge des namens
      );
      l_counter := l_counter + 1;
    end loop;
    --
    return dbms_tf.describe_t(new_columns => l_cols);
  end;

  -- Wir Überprüfen ob ein Eintrag existiert oder nicht in der M-N Tabelle
  function exists_row(
    p_datum date,
    --p_planung_schichten_id number,
    p_mitarbeiter_id varchar2 
  ) return boolean
  is
    l_dummy number;
  begin
    select 1
      into l_dummy
      from solution_desk_ma_codes_v
     where datum = p_datum
     --where planung_schichten_id = p_planung_schichten_id
       and mitarbeiter_id = p_mitarbeiter_id;
    return true;
  exception
    when no_data_found then
      return false;
    when too_many_rows then
      return true;  
  end;

    function get_vorgabe_code(
    p_datum DATE,
    p_planung_schichten_id NUMBER,
    p_mitarbeiter_id VARCHAR2
    ) RETURN VARCHAR2
    IS
    l_vorgabe_code_id VARCHAR2(20);
    l_archiv_table_name VARCHAR2(100);
    BEGIN
    -- Identifizieren der entsprechenden Archivtabelle für das Datum
    l_archiv_table_name := 'ARCHIV_PLANUNG_SCHICHTEN_' || EXTRACT(YEAR FROM p_datum)
        || '_' || CASE WHEN EXTRACT(MONTH FROM p_datum) <= 6 THEN 1 ELSE 2 END;

    -- Überprüfen, ob die Archivtabelle existiert
    DECLARE
        l_table_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO l_table_count
        FROM USER_TABLES
        WHERE TABLE_NAME = l_archiv_table_name;

        IF l_table_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Die Tabelle ' || l_archiv_table_name || ' ist nicht vorhanden.');
        RETURN apex_item.text(
            p_idx       => 1,
            p_value     => '',
            p_size      => 7,
            p_item_id   => (TO_CHAR(p_datum, 'DD.MM.YYYY') || ':' || p_mitarbeiter_id)
        ); -- Rückgabe eines leeren Vorgabecodes, wenn die Archivtabelle nicht vorhanden ist
        END IF;
    END;

    -- Abfrage des Vorgabecodes aus der Archivtabelle
    BEGIN
        EXECUTE IMMEDIATE 'SELECT vorgabe_code_id FROM ' || l_archiv_table_name ||
                          ' WHERE DATUM = :datum AND MITARBEITER_ID = :mitarbeiter_id'
            INTO l_vorgabe_code_id
            USING p_datum, p_mitarbeiter_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            l_vorgabe_code_id := '';
    END;

    -- Rückgabe des Vorgabecodes
    RETURN apex_item.text(
        p_idx       => 1,
        p_value     => l_vorgabe_code_id,
        p_size      => 7,
        p_item_id   => (TO_CHAR(p_datum, 'DD.MM.YYYY') || ':' || p_mitarbeiter_id)
    );
    END get_vorgabe_code;


  -- Die Interface Funktion von Polymorphic
  procedure fetch_rows(p_object_hash raw)
  is
    l_rowset dbms_tf.row_set_t;
    l_env    dbms_tf.env_t;
    l_colcnt pls_integer;
    l_rowcnt pls_integer;
    --
    l_usr_id number;
    l_rol_id number;
    l_ncol   dbms_tf.tab_varchar2_t;
  begin
    -- Matrix laden
    dbms_tf.get_row_set (
      l_rowset
    , l_rowcnt
    , l_colcnt
    );
    -- Spalten Envoirment und Infos laden
    l_env := dbms_tf.get_env();
    -- Wir füllen hier nun Spalte für Spalte die Matrix
    for col in 1 .. l_env.put_columns.count
    loop
      -- Nun Wird für jede Zeile geguckt welche Daten vorhanden sind.
      for row in 1 .. l_rowcnt 
      loop
        l_ncol(row) := get_vorgabe_code(
          p_datum => l_rowset(2).tab_date(row), --to_date(),--'01.12.2022',--to_date(l_rowset(1).tab_varchar2(row)), --replace(l_env.get_columns(col).name,'"'),--to_date(l_rowset(1).tab_number(rows)),  --.datum,'01.12.2022'
          p_planung_schichten_id => l_rowset(1).tab_number(row),
          p_mitarbeiter_id => replace(l_env.put_columns(col).name,'"', '')
        );
        
        dbms_output.put_line('date:'|| l_rowset(2).tab_date(row) || 'Mitarbeiter: ' || l_env.put_columns(col).name);
      end loop;
      dbms_tf.put_col(col, l_ncol);
    end loop;
  end;

  -- Raus suchen aller Möglichen Spalten und wiedergabe mit einem Separator
  function get_columns(p_seperator varchar2)
    return varchar2
  is
     l_return varchar2(20000);
  begin
     select listagg(mitarbeiter_id, p_seperator)within group(order by reihenfolge asc)
       into l_return
       from mitarbeiter
       where rolle_id = 'MA';
     return l_return;
  end;  

  -- Hash holen für alle Mitarbeiter
  function get_hash
    return raw
  is
     l_return raw(2000);
  begin
     select standard_hash(listagg(mitarbeiter_id)within group(order by reihenfolge asc), 'MD5')
       into l_return
       from mitarbeiter;
     return l_return;
  end;  

    -- Wir bauen hier den Select, der nachher in Apex gebaut wird.
    -- Wir holen hart die wichtigen Werte aus den Zeilen (Usr_id und usr_name)
    -- Des weiteren holen wir über get columns und den Separator , alle weiteren Rollen für den Select
    FUNCTION get_polymorphic_sql(p_datum VARCHAR2) RETURN VARCHAR2 IS
    l_mitarbeiter CONSTANT VARCHAR2(2000) := get_columns(p_seperator => ',');
    l_hash CONSTANT RAW(2000) := get_hash;
    l_datum VARCHAR2(2000) := p_datum;
    l_neues_datum DATE;
    l_archiv_table_name VARCHAR2(2000);
    BEGIN
    l_neues_datum := TO_DATE(l_datum, 'MON YYYY');
    l_neues_datum := ADD_MONTHS(l_neues_datum, 0);
    l_datum := TO_CHAR(l_neues_datum, 'DD.MM.YYYY');
    
    -- Generiere den Namen der Archivtabelle basierend auf dem ausgewählten Monat
    l_archiv_table_name := 'ARCHIV_PLANUNG_SCHICHTEN_' || EXTRACT(YEAR FROM l_neues_datum) || '_' || CASE WHEN EXTRACT(MONTH FROM l_neues_datum) <= 6 THEN 1 ELSE 2 END;
    RETURN
        q'~SELECT DISTINCT datum,~' || l_mitarbeiter || q'~,'' Kommentar,6,7,9,14,22,12
          FROM archiv_planung_schichten_matrix_pkg.polymorphic_table(~' || l_archiv_table_name || q'~,'~'|| l_hash || q'~')
          WHERE datum >= TO_DATE('~'|| l_datum ||q'~', 'DD.MM.YYYY')
            AND datum <= TO_DATE('~'|| l_datum ||q'~', 'DD.MM.YYYY') + INTERVAL '31' DAY
          ORDER BY datum ASC~';
    END;



  function get_monat_sum_h_sql(p_datum varchar2)
    return varchar2
  is
     l_mitarbeiter constant varchar2(20000) := get_columns(p_seperator => ',');
     l_hash  constant raw(20000)            := get_hash;
     l_datum varchar(200)                   := p_datum;
     l_neues_datum date;
     l_archiv_table_name VARCHAR2(2000);
  begin
     l_neues_datum := to_date(l_datum, 'MON YYYY');
     l_neues_datum := add_months(l_neues_datum, 0);
     l_datum := to_char(l_neues_datum, 'DD.MM.YYYY');
     l_archiv_table_name := 'ARCHIV_PLANUNG_SCHICHTEN_' || EXTRACT(YEAR FROM l_neues_datum) || '_' || CASE WHEN EXTRACT(MONTH FROM l_neues_datum) <= 6 THEN 1 ELSE 2 END;
    return (q'~ select to_char(datum, 'MON YYYY') as monat,~' || l_mitarbeiter || q'~ from archiv_planung_schichten_matrix_pkg.polymorphic_table(~' || l_archiv_table_name || q'~,'~'||l_hash||q'~') where to_char(datum, 'MON') = to_char(to_date('~'|| l_datum ||q'~'), 'MON') fetch first row only ~');
  end;  
 
  function get_polymorphic_headings
    return varchar2
  is
  begin
     return 'Datum:'||replace(get_columns(p_seperator => ':'), 'ma_')||':Kommentar:6:7:9:14:22:12'; --planung_schichten_id:
  end;
  
  function get_polymorphic_headings_monat_sum_h
    return varchar2
  is
  begin
     return 'Monat:'||replace(get_columns(p_seperator => ':'), 'ma_');
  end;
  
end ARCHIV_PLANUNG_SCHICHTEN_MATRIX_PKG;
/