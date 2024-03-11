-- exported with dbms_metadata.get_ddl
create or replace force editionable view solution_desk_ma_codes_v (planung_schichten_id, vorgabe_code_id, mitarbeiter_id, datum, wochentag) as 
  select 
ps.planung_schichten_id,
ps.vorgabe_code_id,
ps.mitarbeiter_id,
trunc(ps.datum) datum,
ps.wochentag
from planung_schichten ps;