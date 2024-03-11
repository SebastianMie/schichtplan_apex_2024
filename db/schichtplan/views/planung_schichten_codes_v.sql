-- exported with dbms_metadata.get_ddl
create or replace force editionable view planung_schichten_codes_v (planung_schichten_id, datum, wochentag, mitarbeiter_id, vorgabe_code_id, service_team_id, startzeit, endzeit, startzeit_h, endzeit_h, beschreibung) as 
  select 
ps.planung_schichten_id,
ps.datum,
ps.wochentag,
ps.mitarbeiter_id,
ps.vorgabe_code_id,
ps.service_team_id,
ps.startzeit,
ps.endzeit,
vc.startzeit_h,
vc.endzeit_h,
vc.beschreibung
from planung_schichten ps
join vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id;