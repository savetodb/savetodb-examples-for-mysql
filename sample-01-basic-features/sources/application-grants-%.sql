-- =============================================
-- Application: Sample 01 - Basic SaveToDB Features
-- Version 10.6, December 13, 2022
--
-- Copyright 2014-2022 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample01_user1'@'%' IDENTIFIED BY 'Usr_2011#_Xls4168';
CREATE USER 'sample01_user2'@'%' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s01.* TO 'sample01_user1'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s01.* TO 'sample01_user2'@'%';

GRANT SHOW VIEW ON s01.* TO 'sample01_user1'@'%';
