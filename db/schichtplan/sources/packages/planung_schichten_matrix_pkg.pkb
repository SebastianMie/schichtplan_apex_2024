create or replace PACKAGE BODY planung_schichten_matrix_pkg as
    
  -- Diese Prozedur gibt uns die Namen für die Spalten
  function describe (
    p_table         in out dbms_tf.table_t,
    p_object_hash   raw
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
    for mitarbeiter in (
      select mitarbeiter_id
      from mitarbeiter
      where rolle_id = 'MA'
    )
    loop
      l_cols(l_counter) := dbms_tf.column_metadata_t (
        name     => upper(mitarbeiter.mitarbeiter_id),      -- Hier müssen wir noch auf Probleme Aufpassen wie Leerzeich oder Minus im Spaltennamen
        type     => dbms_tf.type_varchar2,                  -- Könnte hier auch 
        name_len => length(mitarbeiter.mitarbeiter_id)      -- Nehmen hier einfach die Länge des namens
      );
      l_counter := l_counter + 1;
    end loop;
    --
    return dbms_tf.describe_t(new_columns => l_cols);
  end;

  function get_vorgabe_code(
    p_datum DATE,
    p_mitarbeiter_id VARCHAR2
  ) RETURN VARCHAR2
  is
    l_value VARCHAR2(200);
  begin
    begin
      select vorgabe_code_id
      into l_value
      from planung_schichten
      where datum = p_datum
      and mitarbeiter_id = p_mitarbeiter_id;
    exception
      when NO_DATA_FOUND then
        null;
    end;

    -- Rückgabe des Texteingabefelds für den Vorgabe-Code 
    return apex_item.text(
      p_idx       => 1,
      p_value     => l_value,
      p_size      => 7,
      p_item_id   => (to_char(p_datum, 'DD.MM.YYYY') || ':' || p_mitarbeiter_id)
    );
  end;

  procedure fetch_rows(p_object_hash raw)
  is
    l_rowset dbms_tf.row_set_t;
    l_env    dbms_tf.env_t;
    l_colcnt pls_integer;
    l_rowcnt pls_integer;
    l_ncol   dbms_tf.tab_varchar2_t;
  begin
    -- Matrix laden
    dbms_tf.get_row_set (
      l_rowset,
      l_rowcnt,
      l_colcnt
    );
    -- Spalten Envoirment und Infos laden
    l_env := dbms_tf.get_env();
    -- Wir füllen hier nun Spalte für Spalte die Matrix
    for col in 1 .. l_env.put_columns.count loop  
      -- Nun wird für jede Zeile überprüft, welche Daten vorhanden sind
      for row in 1 .. l_rowcnt loop
        l_ncol(row) := get_vorgabe_code(
          p_datum => l_rowset(2).tab_date(row),
          p_mitarbeiter_id => replace(l_env.put_columns(col).name, '"', '')
        );
      end loop;
      dbms_tf.put_col(col, l_ncol);
    end loop;
  end;

    -- Raus suchen aller Möglichen Spalten und Wiedergabe mit einem Separator
    function get_columns(p_seperator varchar2, p_monat varchar2) 
      return varchar2 
    is 
      l_return varchar2(20000); 
    begin 
      if to_date(p_monat, 'MON YYYY') < trunc(sysdate, 'MM') - interval '2' month then 
        -- Für Monate mehr als 2 Monate in der Vergangenheit
        select listagg(mitarbeiter_id, p_seperator) within group (order by reihenfolge asc) 
        into l_return 
        from mitarbeiter 
        where (to_date(p_monat, 'MON YYYY') < trunc(sysdate, 'MM') - interval '2' month and exists (select 1 from planung_schichten where mitarbeiter_id = mitarbeiter.mitarbeiter_id and vorgabe_code_id is not null and trunc(datum, 'MM') = trunc(to_date(p_monat, 'MON YYYY'), 'MM')))
        or (to_date(p_monat, 'MON YYYY') >= trunc(sysdate, 'MM') and exists (select 1 from planung_schichten where mitarbeiter_id = mitarbeiter.mitarbeiter_id and vorgabe_code_id is not null and trunc(datum, 'MM') = trunc(to_date(p_monat, 'MON YYYY'), 'MM')))
        or (to_date(p_monat, 'MON YYYY') >= trunc(sysdate, 'MM') - interval '1' month and exists (select 1 from planung_schichten where mitarbeiter_id = mitarbeiter.mitarbeiter_id and vorgabe_code_id is not null and trunc(datum, 'MM') = trunc(to_date(p_monat, 'MON YYYY'), 'MM')));
      elsif to_date(p_monat, 'MON YYYY') >= trunc(sysdate, 'MM') - interval '2' month and to_date(p_monat, 'MON YYYY') < trunc(sysdate, 'MM') then
        -- Für die letzten drei Monate in der Vergangenheit bis zur Gegenwart
        select listagg(mitarbeiter_id, p_seperator) within group (order by reihenfolge asc) 
        into l_return 
        from mitarbeiter 
        where rolle_id = 'MA'
        and aktiv = 'Y';
      else
        -- Für Gegenwart und Zukunft
        select listagg(mitarbeiter_id, p_seperator) within group (order by reihenfolge asc) 
        into l_return 
        from mitarbeiter 
        where rolle_id = 'MA' 
        and aktiv = 'Y';
      end if;
      return l_return; 
    end;

  -- Raus suchen aller Möglichen Spalten und wiedergabe mit einem Separator
  function get_columns(p_seperator varchar2)
    return varchar2
  is
    l_return varchar2(20000);
  begin
    select listagg(mitarbeiter_id, p_seperator) within group(order by reihenfolge asc)
    into l_return
    from mitarbeiter
    where rolle_id = 'MA'
    and aktiv = 'Y';
    return l_return;
  end get_columns;

  -- Hash holen für alle Mitarbeiter
  function get_hash
    return raw
  is
    l_return raw(2000);
  begin
    select standard_hash(listagg(mitarbeiter_id) within group(order by reihenfolge asc), 'MD5')
    into l_return
    from mitarbeiter;
    return l_return;
  end get_hash;

  -- Wir bauen hier den Select, der nachher in Apex gebaut wird.
  -- Wir holen hart die wichtigen Werte aus den Zeilen (Usr_id und usr_name)
  -- Des weiteren holen wir über get columns und den Separator , alle weiteren Rollen für den Select
  function get_polymorphic_sql(p_monat varchar2) return varchar2
  is
    l_mitarbeiter constant varchar2(2000) := get_columns(p_seperator => ',', p_monat => p_monat);
    l_hash constant raw(2000) := get_hash;
    l_pol_sql varchar2(2000); -- Spalte für Rufbereitschaften

  begin
    l_pol_sql := q'~with aktueller_monat as (select* from planung_schichten where to_char(datum, 'MON YYYY') = '~'|| p_monat ||q'~')
        select distinct datum,~' || l_mitarbeiter || q'~,6,7,9,14,22,1222,1210,'' kommentar 
        from planung_schichten_matrix_pkg.polymorphic_table(aktueller_monat, '~'||utl_raw.cast_to_raw(p_monat)||q'~')
        order by datum asc ~';
    return l_pol_sql;
  end;

  function get_matrix_day_sql(p_day varchar2) return varchar2
  is
    l_mitarbeiter constant varchar2(2000) := get_columns(p_seperator => ',');
    l_hash constant raw(2000) := get_hash;
    l_pol_sql varchar2(2000); -- Spalte für Rufbereitschaften

  begin
    l_pol_sql := q'~with aktueller_monat as (select * from planung_schichten where to_char(datum, 'DD.MM.YYYY') = '~'|| p_day ||q'~')
        select distinct datum,~' || l_mitarbeiter || q'~
        from planung_schichten_matrix_pkg.polymorphic_table(aktueller_monat, '~'||utl_raw.cast_to_raw(p_day)||q'~')
        order by datum asc ~';
    return l_pol_sql;
  end;

  function get_polymorphic_headings(p_monat varchar2)
    return varchar2
  is
  begin
    return 'Datum:'||get_columns(':',p_monat)||':6:7:9:14:22:12ab22:12ab10:&nbsp;';
  end;

end planung_schichten_matrix_pkg;
/