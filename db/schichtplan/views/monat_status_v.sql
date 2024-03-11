-- exported with dbms_metadata.get_ddl
create or replace force editionable view monat_status_v (monat_planung_id, monat_jahr, ref_status_id) as 
  select 
    monat_planung_id,monat_jahr,ref_status_id
from monat_planung
order by to_date(monat_jahr, 'MON YYYY');