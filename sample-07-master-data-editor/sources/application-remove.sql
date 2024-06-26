-- =============================================
-- Application: Sample 07 - Master Data Editor
-- Version 10.13, April 29, 2024
--
-- Copyright 2017-2024 Gartle LLC
--
-- License: MIT
-- =============================================

DROP TABLE s07.employee_territories;
DROP TABLE s07.employees;
DROP TABLE s07.territories;
DROP TABLE s07.region;

DROP SCHEMA s07;

DROP USER 'sample07_user1'@'localhost';

DROP USER 'sample07_user1'@'%';

-- print Application removed
