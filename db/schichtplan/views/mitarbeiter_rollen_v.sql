-- exported with dbms_metadata.get_ddl
create or replace force editionable view mitarbeiter_rollen_v (vorname, nachname, rolle_id, bezeichnung) as 
  select 
    m.vorname,
    m.nachname,
    m.rolle_id,
    r.bezeichnung
from mitarbeiter m 
join rollen r on r.rolle_id = m.rolle_id;