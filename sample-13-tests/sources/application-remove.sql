-- =============================================
-- Application: Sample 13 - Tests
-- Version 10.8, January 9, 2023
--
-- Copyright 2021-2023 Gartle LLC
--
-- License: MIT
-- =============================================

DROP PROCEDURE IF EXISTS s13.usp_datatypes;
DROP PROCEDURE IF EXISTS s13.usp_datatypes_delete;
DROP PROCEDURE IF EXISTS s13.usp_datatypes_insert;
DROP PROCEDURE IF EXISTS s13.usp_datatypes_update;

DROP PROCEDURE IF EXISTS s13.usp_odbc_datatypes;
DROP PROCEDURE IF EXISTS s13.usp_odbc_datatypes_delete;
DROP PROCEDURE IF EXISTS s13.usp_odbc_datatypes_insert;
DROP PROCEDURE IF EXISTS s13.usp_odbc_datatypes_update;

DROP PROCEDURE IF EXISTS s13.usp_quotes;
DROP PROCEDURE IF EXISTS s13.usp_quotes_delete;
DROP PROCEDURE IF EXISTS s13.usp_quotes_insert;
DROP PROCEDURE IF EXISTS s13.usp_quotes_update;

DROP VIEW  IF EXISTS s13.view_datatype_parameters;
DROP VIEW  IF EXISTS s13.view_datatype_columns;

DROP TABLE IF EXISTS s13.datatypes;
DROP TABLE IF EXISTS s13.quotes;

DROP SCHEMA s13;

DROP USER 'sample13_user1'@'localhost';

DROP USER 'sample13_user1'@'%';

-- print Application removed
