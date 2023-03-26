-- =============================================
-- Application: Sample 02 - Advanced SaveToDB Features
-- Version 10.8, January 9, 2023
--
-- Copyright 2017-2023 Gartle LLC
--
-- License: MIT
-- =============================================

DELETE FROM xls.formats         WHERE TABLE_SCHEMA IN ('s02');
DELETE FROM xls.handlers        WHERE TABLE_SCHEMA IN ('s02');
DELETE FROM xls.objects         WHERE TABLE_SCHEMA IN ('s02');
DELETE FROM xls.translations    WHERE TABLE_SCHEMA IN ('s02');
DELETE FROM xls.workbooks       WHERE TABLE_SCHEMA IN ('s02');

DROP PROCEDURE  IF EXISTS s02.usp_cash_by_months;
DROP PROCEDURE  IF EXISTS s02.usp_cash_by_months_change;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook2;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook2_insert;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook2_update;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook2_delete;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook3;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook3_update;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook4;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook4_merge;
DROP PROCEDURE  IF EXISTS s02.usp_cashbook5;

DROP PROCEDURE  IF EXISTS s02.xl_details_cash_by_months;
DROP PROCEDURE  IF EXISTS s02.xl_list_account_id;
DROP PROCEDURE  IF EXISTS s02.xl_list_company_id_for_item_id;
DROP PROCEDURE  IF EXISTS s02.xl_list_item_id;
DROP PROCEDURE  IF EXISTS s02.xl_list_account_id;
DROP PROCEDURE  IF EXISTS s02.xl_list_company_id_with_item_id;
DROP PROCEDURE  IF EXISTS s02.xl_list_item_id;

DROP VIEW   IF EXISTS s02.view_cashbook;
DROP VIEW   IF EXISTS s02.view_cashbook2;
DROP VIEW   IF EXISTS s02.view_cashbook3;
DROP VIEW   IF EXISTS s02.xl_actions_online_help;

DROP TABLE  IF EXISTS s02.cashbook;
DROP TABLE  IF EXISTS s02.accounts;
DROP TABLE  IF EXISTS s02.item_companies;
DROP TABLE  IF EXISTS s02.companies;
DROP TABLE  IF EXISTS s02.items;

DROP SCHEMA IF EXISTS s02;

DROP USER 'sample02_user1'@'localhost';
DROP USER 'sample02_user2'@'localhost';
DROP USER 'sample02_user3'@'localhost';

DROP USER 'sample02_user1'@'%';
DROP USER 'sample02_user2'@'%';
DROP USER 'sample02_user3'@'%';

-- print Application removed
