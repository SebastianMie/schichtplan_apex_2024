-- exported with dbms_metadata.get_ddl
create or replace force editionable view schichtplanung_report_auslastung (monat, mitarbeiter_id, vorname, nachname, gesamte_arbeitszeit) as 
  select 
    to_char(ps.datum, 'MON YYYY') as monat,
    ps.mitarbeiter_id,
    m.vorname,
    m.nachname,
    sum(vc.dauer_h) as gesamte_arbeitszeit
from planung_schichten ps
join vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id
join mitarbeiter m on m.mitarbeiter_id = ps.mitarbeiter_id
group by to_char(ps.datum, 'MON YYYY'), ps.mitarbeiter_id, m.vorname, m.nachname;