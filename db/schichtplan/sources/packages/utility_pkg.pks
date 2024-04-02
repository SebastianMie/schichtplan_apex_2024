CREATE OR REPLACE EDITIONABLE PACKAGE utility_pkg as 

procedure generate_dates_for_ma(
    p_datum_bis in date
);

procedure insert_rows_laender_monat_limit;

procedure insert_comments_for_all_days;

procedure update_planung_schichten_zeitraum;

procedure update_password_hash(
    p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type,
    p_password in varchar2,
    p_confirm_password in varchar2
);

procedure init_and_update_password_hashes;

function generate_password_hash (
    p_password in varchar2,
    p_salt in varchar2
  ) return varchar2;

function get_status(
    p_month varchar2
) return varchar2; 

function user_adm_authorization(
    p_user_id varchar2
) return boolean;

function get_monat_ma_sum_h (
      p_datum in date,
      p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type
    ) return number;

function save_matrix_mitarbeiter (
    p_datum in date,
    p_mitarbeiter_id in mitarbeiter.mitarbeiter_id%type,
    p_vorgabe_code_id in varchar2
) return varchar2;

function save_matrix_mitarbeiter (
    p_matrix_data IN matrix_table_type
) return varchar2;

procedure generate_future_months;

FUNCTION get_last_sperre_info (
      p_app_user in VARCHAR2
) return varchar2;

function get_last_sperre_ma return varchar2;

end utility_pkg;
/