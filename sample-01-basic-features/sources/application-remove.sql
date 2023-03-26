-- =============================================
-- Application: Sample 01 - Basic SaveToDB Features
-- Version 10.8, January 9, 2023
--
-- Copyright 2014-2023 Gartle LLC
--
-- License: MIT
-- =============================================

DROP PROCEDURE  IF EXISTS s01.usp_cash_by_months;
DROP PROCEDURE  IF EXISTS s01.usp_cash_by_months_change;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook2;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook2_insert;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook2_update;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook2_delete;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook3;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook3_update;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook4;
DROP PROCEDURE  IF EXISTS s01.usp_cashbook4_merge;

DROP VIEW       IF EXISTS s01.view_cashbook;

DROP TABLE      IF EXISTS s01.cashbook;
DROP TABLE      IF EXISTS s01.formats;
DROP TABLE      IF EXISTS s01.workbooks;

DROP SCHEMA     IF EXISTS s01;

DROP USER 'sample01_user1'@'localhost';
DROP USER 'sample01_user2'@'localhost';

DROP USER 'sample01_user1'@'%';
DROP USER 'sample01_user2'@'%';

-- print Application removed
