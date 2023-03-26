-- =============================================
-- Application: Sample 13 - Tests
-- Version 10.8, January 9, 2023
--
-- Copyright 2021-2023 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample13_user1'@'localhost' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE ON s13.datatypes       TO 'sample13_user1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON s13.quotes          TO 'sample13_user1'@'localhost';

GRANT SELECT ON s13.view_datatype_parameters                TO 'sample13_user1'@'localhost';
GRANT SELECT ON s13.view_datatype_columns                   TO 'sample13_user1'@'localhost';

GRANT EXECUTE ON PROCEDURE s13.usp_datatypes                TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_delete         TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_insert         TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_update         TO 'sample13_user1'@'localhost';

GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes           TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_delete    TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_insert    TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_update    TO 'sample13_user1'@'localhost';

GRANT EXECUTE ON PROCEDURE s13.usp_quotes                   TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_delete            TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_insert            TO 'sample13_user1'@'localhost';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_update            TO 'sample13_user1'@'localhost';
