-- =============================================
-- SaveToDB Framework Extension for MySQL
-- Version 10.6, December 13, 2022
--
-- Copyright 2022 Gartle LLC
--
-- License: MIT
-- =============================================

DELETE FROM xls.formats   WHERE TABLE_SCHEMA = 'xls' AND TABLE_NAME IN ('view_columns', 'view_formats', 'view_handlers', 'view_objects', 'view_queries', 'view_translations', 'view_workbooks');
DELETE FROM xls.handlers  WHERE TABLE_SCHEMA = 'xls' AND TABLE_NAME IN ('view_columns', 'view_formats', 'view_handlers', 'view_objects', 'view_queries', 'view_translations', 'view_workbooks', 'savetodb_framework_extension');
DELETE FROM xls.workbooks WHERE TABLE_SCHEMA = 'xls' AND NAME IN ('savetodb_user_configuration.xlsx');

DROP PROCEDURE IF EXISTS xls.xl_update_table_format;

DROP VIEW IF EXISTS xls.view_columns;
DROP VIEW IF EXISTS xls.view_formats;
DROP VIEW IF EXISTS xls.view_handlers;
DROP VIEW IF EXISTS xls.view_objects;
DROP VIEW IF EXISTS xls.view_queries;
DROP VIEW IF EXISTS xls.view_translations;
DROP VIEW IF EXISTS xls.view_workbooks;

-- print SaveToDB Framework Extension removed
