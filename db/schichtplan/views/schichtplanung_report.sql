-- exported with dbms_metadata.get_ddl
create or replace force editionable view schichtplanung_report (planung_schichten_id, datum, wochentag, mitarbeiter_id, vorgabe_code_id, service_team_id, startzeit, endzeit, startzeit_h, endzeit_h, beschreibung, vorname, nachname) as 
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
vc.beschreibung,
m.vorname,
m.nachname
from planung_schichten ps
join vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id
join mitarbeiter m on m.mitarbeiter_id = ps.mitarbeiter_id;