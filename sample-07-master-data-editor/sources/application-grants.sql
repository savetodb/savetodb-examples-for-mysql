-- =============================================
-- Application: Sample 07 - Master Data Editor
-- Version 10.13, April 29, 2024
--
-- Copyright 2017-2024 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample07_user1'@'localhost' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s07.* TO 'sample07_user1'@'localhost';
