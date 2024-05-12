-- =============================================
-- Application: Sample 13 - Tests
-- Version 10.13, April 29, 2024
--
-- Copyright 2021-2024 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample13_user1'@'%' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE ON s13.datatypes       TO 'sample13_user1'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON s13.quotes          TO 'sample13_user1'@'%';

GRANT SELECT ON s13.view_datatype_parameters                TO 'sample13_user1'@'%';
GRANT SELECT ON s13.view_datatype_columns                   TO 'sample13_user1'@'%';

GRANT EXECUTE ON PROCEDURE s13.usp_datatypes                TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_delete         TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_insert         TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_datatypes_update         TO 'sample13_user1'@'%';

GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes           TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_delete    TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_insert    TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_odbc_datatypes_update    TO 'sample13_user1'@'%';

GRANT EXECUTE ON PROCEDURE s13.usp_quotes                   TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_delete            TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_insert            TO 'sample13_user1'@'%';
GRANT EXECUTE ON PROCEDURE s13.usp_quotes_update            TO 'sample13_user1'@'%';
