CREATE OR REPLACE EDITIONABLE PACKAGE archiv_planung_schichten_matrix_pkg as
  
  function describe (
     p_table         in out  dbms_tf.table_t
   , p_object_hash   raw
  ) return dbms_tf.describe_t;

  procedure fetch_rows(p_object_hash   raw);

  -- Muss hier nur in der Spec vorhanden sein
  function polymorphic_table(
    p_table        table
  , p_object_hash  raw)
  return table pipelined table polymorphic using ARCHIV_PLANUNG_SCHICHTEN_MATRIX_PKG;
 
  function get_polymorphic_sql(
    p_datum  varchar2
   )return varchar2;
   
   function get_monat_sum_h_sql(
    p_datum  varchar2
   )return varchar2;

  function get_polymorphic_headings
  return varchar2;  

  function get_polymorphic_headings_monat_sum_h
  return varchar2;  
    
end ARCHIV_PLANUNG_SCHICHTEN_MATRIX_PKG;
/