-- exported with dbms_metadata.get_ddl
create or replace force editionable view schichtplanung_report_schichten (monat, mitarbeiter_id, vorname, nachname, anzahl_schichten) as 
  select 
    to_char(ps.datum, 'YYYY-MM') as monat,
    ps.mitarbeiter_id,
    m.vorname,
    m.nachname,
    count(*) as anzahl_schichten
from planung_schichten ps
join mitarbeiter m on m.mitarbeiter_id = ps.mitarbeiter_id
group by to_char(ps.datum, 'YYYY-MM'), ps.mitarbeiter_id, m.vorname, m.nachname;