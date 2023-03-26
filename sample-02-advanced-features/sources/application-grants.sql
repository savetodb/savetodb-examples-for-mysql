-- =============================================
-- Application: Sample 02 - Advanced SaveToDB Features
-- Version 10.8, January 9, 2023
--
-- Copyright 2017-2023 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE USER 'sample02_user1'@'localhost' IDENTIFIED BY 'Usr_2011#_Xls4168';
CREATE USER 'sample02_user2'@'localhost' IDENTIFIED BY 'Usr_2011#_Xls4168';
CREATE USER 'sample02_user3'@'localhost' IDENTIFIED BY 'Usr_2011#_Xls4168';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s02.* TO 'sample02_user1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s02.* TO 'sample02_user2'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON s02.* TO 'sample02_user3'@'localhost';

GRANT SHOW VIEW ON s02.*            TO 'sample02_user1'@'localhost';

GRANT SELECT    ON xls.formats      TO 'sample02_user1'@'localhost';
GRANT SELECT    ON xls.workbooks    TO 'sample02_user1'@'localhost';
GRANT SELECT    ON xls.formats      TO 'sample02_user2'@'localhost';
GRANT SELECT    ON xls.workbooks    TO 'sample02_user2'@'localhost';

CALL xls.xl_actions_add_to_xls_users('sample02_user3', 'localhost', 0);
