-- exported with dbms_metadata.get_ddl
create or replace force editionable view heutige_besetzung_v (datum, mitarbeiter_id, vorgabe_code_id) as 
  select 
    datum, mitarbeiter_id, vorgabe_code_id
from planung_schichten;