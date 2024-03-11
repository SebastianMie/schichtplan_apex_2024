CREATE OR REPLACE EDITIONABLE PACKAGE planung_schichten_matrix_pkg as
  -- Wir erstellen hier die Spalten

  function describe (
    p_table         in out  dbms_tf.table_t,
    p_object_hash   raw
  ) return dbms_tf.describe_t;

  procedure fetch_rows(p_object_hash   raw);

  -- Muss hier nur in der Spec vorhanden sein
  function polymorphic_table(
    p_table        table,
    p_object_hash  raw
  ) return table pipelined table polymorphic using planung_schichten_matrix_pkg;
  
  function get_matrix_day_sql(
    p_day varchar2
  ) return varchar2;

  function get_polymorphic_sql(
    p_monat  varchar2
  ) return varchar2;

  function get_polymorphic_headings
    return varchar2;
    
    function get_polymorphic_headings(p_monat varchar2)
    return varchar2;

  function get_vorgabe_code(
    p_datum DATE,
    p_mitarbeiter_id VARCHAR2
  ) return VARCHAR2;
  
   function get_columns(p_seperator varchar2, p_monat varchar2) 
      return varchar2; 

end planung_schichten_matrix_pkg;
/