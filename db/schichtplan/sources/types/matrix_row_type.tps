CREATE OR REPLACE EDITIONABLE TYPE matrix_row_type AS OBJECT (
    datum DATE,
    mitarbeiter_id VARCHAR2(50),
    vorgabe_code_id VARCHAR2(200)
);
/