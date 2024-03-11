CREATE OR REPLACE EDITIONABLE PACKAGE archiv_pkg AS 

  PROCEDURE create_archiv_tables;
  
  PROCEDURE archive_data(p_monat IN VARCHAR2);
  
  PROCEDURE recover_data(p_monat IN VARCHAR2);

END ARCHIV_PKG;
/