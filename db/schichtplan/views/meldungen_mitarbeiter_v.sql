-- exported with dbms_metadata.get_ddl
create or replace force editionable view meldungen_mitarbeiter_v (mitarbeiter_id, datum, beschreibung, kategorie) as 
  select 
    mm.mitarbeiter_id, mm.datum, m.beschreibung, m.kategorie
from meldungen_mitarbeiter mm 
join meldungen m on m.meldung_id = mm.meldung_id;