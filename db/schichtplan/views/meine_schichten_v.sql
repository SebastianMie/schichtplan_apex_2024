-- exported with dbms_metadata.get_ddl
create or replace force editionable view meine_schichten_v (planung_schichten_id, datum, wochentag, vorgabe_code_id, service_team_id, startzeit, endzeit, mitarbeiter_id, vorgabe_farbcode) as 
  select
   ps.planung_schichten_id,
   ps.datum,
   ps.wochentag,
   ps.vorgabe_code_id,
   ps.service_team_id,
   ps.startzeit,
   ps.endzeit,
   ps.mitarbeiter_id,
   vc.farbcode_hex as vorgabe_farbcode
from
   planung_schichten ps
join
   vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id
where
   ps.vorgabe_code_id is not null
   and ps.datum >= sysdate - 7
   and ps.datum <= sysdate + 7;