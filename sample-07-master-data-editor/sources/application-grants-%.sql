-- =============================================
-- Application: Sample 07 - Master Data Editor
-- Version 10.6, December 13, 2022
--
-- Copyright 2017-2022 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample07_user1'@'%' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s07.* TO 'sample07_user1'@'%';
