CREATE OR REPLACE EDITIONABLE PACKAGE BODY planung_sum_h_matrix_pkg AS

  function describe (
    p_table         in out dbms_tf.table_t,
    p_object_hash   raw
  ) return dbms_tf.describe_t
  is
    l_cols dbms_tf.columns_new_t;
    l_counter number := 1;
  begin
    for i in 1 .. p_table.column.count loop
      p_table.column(i).pass_through := true;
      p_table.column(i).for_read     := true;
    end loop;

    for mitarbeiter in (
      select mitarbeiter_id
      from mitarbeiter
      where rolle_id = 'MA'
    )
    loop
      l_cols(l_counter) := dbms_tf.column_metadata_t (
        name     => upper(mitarbeiter.mitarbeiter_id),
        type     => dbms_tf.type_varchar2,
        name_len => length(mitarbeiter.mitarbeiter_id)
      );
      l_counter := l_counter + 1;
    end loop;

    return dbms_tf.describe_t(new_columns => l_cols);
  end describe;

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
    for col in 1 .. l_env.put_columns.count + 2 loop
      -- Nun wird für jede Zeile überprüft, welche Daten vorhanden sind
      for row in 1 .. l_rowcnt loop
        l_ncol(row) := null;
      end loop;
      dbms_tf.put_col(col, l_ncol);
    end loop;
  end fetch_rows;

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
        where rolle_id = 'MA';
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

 function get_polymorphic_headings_monat_sum_h
    return varchar2
  is
  begin
    return 'Monat:'||get_columns(p_seperator => ':');
  END get_polymorphic_headings_monat_sum_h;

  function get_monat_sum_h_sql(p_monat varchar2)
    return varchar2
  is
    l_mitarbeiter constant varchar2(2000) := get_columns(p_seperator => ',', p_monat => p_monat);
    l_hash constant raw(2000) := get_hash;
  begin
    return q'~ select monat_jahr as monat,~' || l_mitarbeiter || q'~ from planung_sum_h_matrix_pkg.polymorphic_table(monat_planung,'~'||l_hash||q'~') where monat_jahr = '~'|| p_monat ||q'~' ~';
  end get_monat_sum_h_sql;

END PLANUNG_SUM_H_MATRIX_PKG;
/