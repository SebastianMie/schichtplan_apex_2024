CREATE OR REPLACE EDITIONABLE PACKAGE constraints_pkg as
  procedure pruefe_constraints_ma(
    p_mitarbeiter_id in varchar2,
    p_monat in date
  );

  procedure pruefe_constraint_35_h(
    p_mitarbeiter_id in varchar2,
    p_monat in date
  );

  procedure pruefe_constraint_urlaub_we(
    p_mitarbeiter_id in varchar2,
    p_monat in date
  );

  procedure insert_meldungen_mitarbeiter(
    p_meldung_id in number,
    p_mitarbeiter_id in varchar2,
    p_datum in date
  );

end constraints_pkg;
/