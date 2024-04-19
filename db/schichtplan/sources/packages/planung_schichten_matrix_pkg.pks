create or replace package planung_schichten_matrix_pkg as

  function describe (
    p_table         in out  dbms_tf.table_t,
    p_object_hash   raw
  ) return dbms_tf.describe_t;

  procedure fetch_rows(p_object_hash raw);

  function polymorphic_table(
    p_table        table,
    p_object_hash  raw
  ) return table pipelined table polymorphic using planung_schichten_matrix_pkg;

  function get_polymorphic_sql(
    p_monat  varchar2
  ) return varchar2;
  
  function get_matrix_day_sql(
    p_day varchar2
  ) return varchar2;

  function get_polymorphic_headings(p_monat varchar2)
    return varchar2;

  function get_vorgabe_code(
    p_datum date,
    p_mitarbeiter_id varchar2
  ) return varchar2;

  function get_columns(p_seperator varchar2, p_monat varchar2) 
    return varchar2; 

end planung_schichten_matrix_pkg;
/