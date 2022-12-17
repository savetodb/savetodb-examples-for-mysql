-- =============================================
-- Application: Sample 02 - Advanced SaveToDB Features
-- Version 10.6, December 13, 2022
--
-- Copyright 2017-2022 Gartle LLC
--
-- License: MIT
-- =============================================

SELECT
    t.TABLE_SCHEMA AS `SCHEMA`
    , t.TABLE_NAME AS `NAME`
    , t.TABLE_TYPE AS `TYPE`
FROM
    INFORMATION_SCHEMA.TABLES t
WHERE
    t.TABLE_SCHEMA IN ('s02')
UNION ALL
SELECT
    r.ROUTINE_SCHEMA AS `SCHEMA`
    , r.ROUTINE_NAME AS `NAME`
    , r.ROUTINE_TYPE AS `TYPE`
FROM
    INFORMATION_SCHEMA.ROUTINES r
WHERE
    r.ROUTINE_SCHEMA IN ('s02')
ORDER BY
    `TYPE`
    , `SCHEMA`
    , `NAME`;
