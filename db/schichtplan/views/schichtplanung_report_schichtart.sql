-- exported with dbms_metadata.get_ddl
create or replace force editionable view schichtplanung_report_schichtart (monat, mitarbeiter_id, vorname, nachname, schichtart, anzahl_schichten) as 
  select 
    to_char(ps.datum, 'YYYY-MM') as monat,
    ps.mitarbeiter_id,
    m.vorname,
    m.nachname,
    vc.vorgabe_code_id as schichtart,
    count(*) as anzahl_schichten
from planung_schichten ps
join vorgabe_codes vc on vc.vorgabe_code_id = ps.vorgabe_code_id
join mitarbeiter m on m.mitarbeiter_id = ps.mitarbeiter_id
group by to_char(ps.datum, 'YYYY-MM'), ps.mitarbeiter_id, m.vorname, m.nachname, vc.vorgabe_code_id;