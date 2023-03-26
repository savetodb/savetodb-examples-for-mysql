-- =============================================
-- Application: Sample 13 - Tests
-- Version 10.8, January 9, 2023
--
-- Copyright 2021-2023 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE SCHEMA s13;

CREATE TABLE s13.quotes (
      `'` VARCHAR(50) NOT NULL
    , `''` VARCHAR(50) NOT NULL
    , `,` VARCHAR(50) NOT NULL
    , `-` VARCHAR(50) NOT NULL
    , `@` VARCHAR(50) NOT NULL
    , `@@` VARCHAR(50) NOT NULL
    , ```` VARCHAR(50) NULL
    , `````` VARCHAR(50) NULL
    , `"` VARCHAR(50) NULL
    , `""` VARCHAR(50) NULL
    , `]` VARCHAR(50) NULL
    , `[` VARCHAR(50) NULL
    , `[]` VARCHAR(50) NULL
    , `+` VARCHAR(50) NULL
    , `%` VARCHAR(50) NULL
    , `%%` VARCHAR(50) NULL
    , `=` VARCHAR(50) NULL
    , `;` VARCHAR(50) NULL
    , `:` VARCHAR(50) NULL
    , `<>` VARCHAR(50) NULL
    , `&` VARCHAR(50) NULL
    , `.` VARCHAR(50) NULL
    , `..` VARCHAR(50) NULL
    , CONSTRAINT pk_quotes PRIMARY KEY (`'`, `''`, `,`, `-`, `@`, `@@`)
);

CREATE TABLE s13.datatypes (
    `id` INT AUTO_INCREMENT NOT NULL
    , `bigint` BIGINT NULL
    , `binary` BINARY(8) NULL
    , `binary16` BINARY(16) NULL
    , `bit1` BIT(1) NULL
    , `bit3` BIT(3) NULL
    , `blob` BLOB NULL
    , `char` CHAR(10) NULL
    , `char36` CHAR(36) NULL
    , `date` DATE NULL
    , `datetime` DATETIME NULL
    , `datetime3` DATETIME(3) NULL
    , `datetime6` DATETIME(6) NULL
    , `decimal152` DECIMAL(15,2) NULL
    , `decimal194` DECIMAL(19,4) NULL
    , `double` DOUBLE NULL
    , `enum` ENUM('x-small', 'small', 'medium', 'large', 'x-large') NULL
    , `float` FLOAT NULL
    , `geometry` GEOMETRY NULL
    , `geometrycollection` GEOMETRYCOLLECTION NULL
    , `int` INT NULL
    , `json` JSON NULL
    , `linestring` LINESTRING NULL
    , `longblob` LONGBLOB NULL
    , `longtext` LONGTEXT NULL
    , `mediumblob` MEDIUMBLOB NULL
    , `mediumint` MEDIUMINT NULL
    , `mediumtext` MEDIUMTEXT NULL
    , `multilinestring` MULTILINESTRING NULL
    , `multipoint` MULTIPOINT NULL
    , `multipolygon` MULTIPOLYGON NULL
    , `point` POINT NULL
    , `polygon` POLYGON NULL
    , `set` SET('a', 'b', 'c', 'd') NULL
    , `smallint` SMALLINT NULL
    , `text` TEXT NULL
    , `time` TIME NULL
    , `time3` TIME(3) NULL
    , `time6` TIME(6) NULL
    , `timestamp` TIMESTAMP NULL
    , `timestamp3` TIMESTAMP(3) NULL
    , `timestamp6` TIMESTAMP(6) NULL
    , `tinyblob` TINYBLOB NULL
    , `tinyint` TINYINT NULL
    , `tinytext` TINYTEXT NULL
    , `varbinary` VARBINARY(1024) NULL
    , `varchar` VARCHAR(255) NULL
    , `year` YEAR NULL
    , CONSTRAINT pk_datatypes PRIMARY KEY (id)
);

CREATE OR REPLACE VIEW s13.view_datatype_columns
AS
SELECT
    c.TABLE_SCHEMA
    , c.TABLE_NAME
    , c.COLUMN_NAME
    , c.ORDINAL_POSITION
    , CASE WHEN INSTR(COLUMN_KEY, 'PRI') > 0 THEN 'YES' ELSE NULL END AS IS_PRIMARY_KEY
    , c.IS_NULLABLE
    , CASE WHEN INSTR(EXTRA, 'auto_increment') > 0 THEN 'YES' ELSE NULL END AS IS_IDENTITY
    , CAST(NULL AS CHAR(3)) AS IS_COMPUTED
    , c.COLUMN_DEFAULT
    , c.DATA_TYPE
    , c.CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH
    , COALESCE(c.NUMERIC_PRECISION, c.DATETIME_PRECISION) AS `PRECISION`
    , c.NUMERIC_SCALE AS SCALE
    , c.COLUMN_TYPE
FROM
    information_schema.COLUMNS c
WHERE
    c.TABLE_SCHEMA NOT IN ('mysql', 'performance_schema', 'sys')
    AND c.TABLE_SCHEMA = 's13' AND c.TABLE_NAME = 'datatypes';

CREATE OR REPLACE VIEW s13.view_datatype_parameters
AS
SELECT
    p.SPECIFIC_SCHEMA
    , p.SPECIFIC_NAME
    , p.ORDINAL_POSITION
    , p.PARAMETER_MODE
    , p.PARAMETER_NAME
    , p.DATA_TYPE
    , p.CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH
    , COALESCE(p.NUMERIC_PRECISION, p.DATETIME_PRECISION) AS `PRECISION`
    , p.NUMERIC_SCALE AS SCALE
FROM
    information_schema.PARAMETERS p
WHERE
    NOT p.SPECIFIC_SCHEMA IN ('information_schema', 'mysql', 'performance_schema', 'sys')
    AND p.SPECIFIC_SCHEMA = 's13'
    AND p.SPECIFIC_NAME LIKE 'usp_datatypes%';

DELIMITER //

CREATE PROCEDURE s13.usp_quotes (
    )
BEGIN

SELECT
      t.`'`
    , t.`''`
    , t.`,`
    , t.`-`
    , t.`@`
    , t.`@@`
    , t.````
    , t.``````
    , t.`"`
    , t.`""`
    , t.`]`
    , t.`[`
    , t.`[]`
    , t.`+`
    , t.`%`
    , t.`%%`
    , t.`=`
    , t.`;`
    , t.`:`
    , t.`<>`
    , t.`&`
    , t.`.`
    , t.`..`
FROM
    s13.quotes t;

END
//

CREATE PROCEDURE s13.usp_quotes_delete (
    _x0027_ VARCHAR(50)
    , _x0027__x0027_ VARCHAR(50)
    , _x002C_ VARCHAR(50)
    , _x002D_ VARCHAR(50)
    , _x0040_ VARCHAR(50)
    , _x0040__x0040_ VARCHAR(50)
    )
BEGIN

DELETE FROM s13.quotes
WHERE
    `'` = _x0027_
    AND `''` = _x0027__x0027_
    AND `,` = _x002C_
    AND `-` = _x002D_
    AND `@` = _x0040_
    AND `@@` = _x0040__x0040_;

END
//

CREATE PROCEDURE s13.usp_quotes_insert (
    _x0027_ VARCHAR(50)
    , _x0027__x0027_ VARCHAR(50)
    , _x002C_ VARCHAR(50)
    , _x002D_ VARCHAR(50)
    , _x0040_ VARCHAR(50)
    , _x0040__x0040_ VARCHAR(50)
    , _x0060_ VARCHAR(50)
    , _x0060__x0060_ VARCHAR(50)
    , _x0022_ VARCHAR(50)
    , _x0022__x0022_ VARCHAR(50)
    , _x005D_ VARCHAR(50)
    , _x005B_ VARCHAR(50)
    , _x005B__x005D_ VARCHAR(50)
    , _x002B_ VARCHAR(50)
    , _x0025_ VARCHAR(50)
    , _x0025__x0025_ VARCHAR(50)
    , _x003D_ VARCHAR(50)
    , _x003B_ VARCHAR(50)
    , _x003A_ VARCHAR(50)
    , _x003C__x003E_ VARCHAR(50)
    , _x0026_ VARCHAR(50)
    , _x002E_ VARCHAR(50)
    , _x002E__x002E_ VARCHAR(50)
    )
BEGIN

INSERT INTO s13.quotes
    ( `'`
    , `''`
    , `,`
    , `-`
    , `@`
    , `@@`
    , ````
    , ``````
    , `"`
    , `""`
    , `]`
    , `[`
    , `[]`
    , `+`
    , `%`
    , `%%`
    , `=`
    , `;`
    , `:`
    , `<>`
    , `&`
    , `.`
    , `..`
    )
VALUES
    ( _x0027_
    , _x0027__x0027_
    , _x002C_
    , _x002D_
    , _x0040_
    , _x0040__x0040_
    , _x0060_
    , _x0060__x0060_
    , _x0022_
    , _x0022__x0022_
    , _x005D_
    , _x005B_
    , _x005B__x005D_
    , _x002B_
    , _x0025_
    , _x0025__x0025_
    , _x003D_
    , _x003B_
    , _x003A_
    , _x003C__x003E_
    , _x0026_
    , _x002E_
    , _x002E__x002E_
    );

END
//

CREATE PROCEDURE s13.usp_quotes_update (
    _x0027_ VARCHAR(50)
    , _x0027__x0027_ VARCHAR(50)
    , _x002C_ VARCHAR(50)
    , _x002D_ VARCHAR(50)
    , _x0040_ VARCHAR(50)
    , _x0040__x0040_ VARCHAR(50)
    , _x0060_ VARCHAR(50)
    , _x0060__x0060_ VARCHAR(50)
    , _x0022_ VARCHAR(50)
    , _x0022__x0022_ VARCHAR(50)
    , _x005D_ VARCHAR(50)
    , _x005B_ VARCHAR(50)
    , _x005B__x005D_ VARCHAR(50)
    , _x002B_ VARCHAR(50)
    , _x0025_ VARCHAR(50)
    , _x0025__x0025_ VARCHAR(50)
    , _x003D_ VARCHAR(50)
    , _x003B_ VARCHAR(50)
    , _x003A_ VARCHAR(50)
    , _x003C__x003E_ VARCHAR(50)
    , _x0026_ VARCHAR(50)
    , _x002E_ VARCHAR(50)
    , _x002E__x002E_ VARCHAR(50)
    )
BEGIN

UPDATE s13.quotes
SET
    ```` = _x0060_
    , `````` = _x0060__x0060_
    , `"` = _x0022_
    , `""` = _x0022__x0022_
    , `]` = _x005D_
    , `[` = _x005B_
    , `[]` = _x005B__x005D_
    , `+` = _x002B_
    , `%` = _x0025_
    , `%%` = _x0025__x0025_
    , `=` = _x003D_
    , `;` = _x003B_
    , `:` = _x003A_
    , `<>` = _x003C__x003E_
    , `&` = _x0026_
    , `.` = _x002E_
    , `..` = _x002E__x002E_
WHERE
    `'` = _x0027_
    AND `''` = _x0027__x0027_
    AND `,` = _x002C_
    AND `-` = _x002D_
    AND `@` = _x0040_
    AND `@@` = _x0040__x0040_;

END
//

CREATE PROCEDURE s13.usp_datatypes (
    )
BEGIN

SELECT
    t.`id`
    , t.`bigint`
    , t.`binary`
    , t.`binary16`
    , t.`bit1`
    , t.`bit3`
    , t.`blob`
    , t.`char`
    , t.`char36`
    , t.`date`
    , t.`datetime`
    , t.`datetime3`
    , t.`datetime6`
    , t.`decimal152`
    , t.`decimal194`
    , t.`double`
    , t.`enum`
    , t.`float`
    , ST_AsText(t.`geometry`) AS `geometry`
    , ST_AsText(t.`geometrycollection`) AS `geometrycollection`
    , t.`int`
    , t.`json`
    , ST_AsText(t.`linestring`) AS `linestring`
    , t.`longblob`
    , t.`longtext`
    , t.`mediumblob`
    , t.`mediumint`
    , t.`mediumtext`
    , ST_AsText(t.`multilinestring`) AS `multilinestring`
    , ST_AsText(t.`multipoint`) AS `multipoint`
    , ST_AsText(t.`multipolygon`) AS `multipolygon`
    , ST_AsText(t.`point`) AS `point`
    , ST_AsText(t.`polygon`) AS `polygon`
    , t.`set`
    , t.`smallint`
    , t.`text`
    , t.`time`
    , t.`time3`
    , t.`time6`
    , t.`timestamp`
    , t.`timestamp3`
    , t.`timestamp6`
    , t.`tinyblob`
    , t.`tinyint`
    , t.`tinytext`
    , t.`varbinary`
    , t.`varchar`
    , t.`year`
FROM
    s13.datatypes t;

END
//

CREATE PROCEDURE s13.usp_datatypes_delete (
    `id` INT
    )
BEGIN

DELETE FROM s13.datatypes
WHERE
    s13.datatypes.`id` = `id`;

END
//

CREATE PROCEDURE s13.usp_datatypes_insert (
    `bigint` BIGINT
    , `binary` BINARY(8)
    , `binary16` BINARY(16)
    , `bit1` BIT(1)
    , `bit3` BIT(3)
    , `blob` BLOB
    , `char` CHAR(10)
    , `char36` CHAR(36)
    , `date` DATE
    , `datetime` DATETIME
    , `datetime3` DATETIME(3)
    , `datetime6` DATETIME(6)
    , `decimal152` DECIMAL(15,2)
    , `decimal194` DECIMAL(19,4)
    , `double` DOUBLE
    , `enum` ENUM('x-small', 'small', 'medium', 'large', 'x-large')
    , `float` FLOAT
    , `geometry` GEOMETRY
    , `geometrycollection` GEOMETRYCOLLECTION
    , `int` INT
    , `json` JSON
    , `linestring` LINESTRING
    , `longblob` LONGBLOB
    , `longtext` LONGTEXT
    , `mediumblob` MEDIUMBLOB
    , `mediumint` MEDIUMINT
    , `mediumtext` MEDIUMTEXT
    , `multilinestring` MULTILINESTRING
    , `multipoint` MULTIPOINT
    , `multipolygon` MULTIPOLYGON
    , `point` POINT
    , `polygon` POLYGON
    , `set` SET('a', 'b', 'c', 'd')
    , `smallint` SMALLINT
    , `text` TEXT
    , `time` TIME
    , `time3` TIME(3)
    , `time6` TIME(6)
    , `timestamp` TIMESTAMP
    , `timestamp3` TIMESTAMP(3)
    , `timestamp6` TIMESTAMP(6)
    , `tinyblob` TINYBLOB
    , `tinyint` TINYINT
    , `tinytext` TINYTEXT
    , `varbinary` VARBINARY(1024)
    , `varchar` VARCHAR(255)
    , `year` YEAR
    )
BEGIN

INSERT INTO s13.datatypes
    ( `bigint`
    , `binary`
    , `binary16`
    , `bit1`
    , `bit3`
    , `blob`
    , `char`
    , `char36`
    , `date`
    , `datetime`
    , `datetime3`
    , `datetime6`
    , `decimal152`
    , `decimal194`
    , `double`
    , `enum`
    , `float`
    , `geometry`
    , `geometrycollection`
    , `int`
    , `json`
    , `linestring`
    , `longblob`
    , `longtext`
    , `mediumblob`
    , `mediumint`
    , `mediumtext`
    , `multilinestring`
    , `multipoint`
    , `multipolygon`
    , `point`
    , `polygon`
    , `set`
    , `smallint`
    , `text`
    , `time`
    , `time3`
    , `time6`
    , `timestamp`
    , `timestamp3`
    , `timestamp6`
    , `tinyblob`
    , `tinyint`
    , `tinytext`
    , `varbinary`
    , `varchar`
    , `year`
    )
VALUES
    ( `bigint`
    , `binary`
    , `binary16`
    , `bit1`
    , `bit3`
    , `blob`
    , `char`
    , `char36`
    , `date`
    , `datetime`
    , `datetime3`
    , `datetime6`
    , `decimal152`
    , `decimal194`
    , `double`
    , `enum`
    , `float`
    , `geometry`
    , `geometrycollection`
    , `int`
    , `json`
    , `linestring`
    , `longblob`
    , `longtext`
    , `mediumblob`
    , `mediumint`
    , `mediumtext`
    , `multilinestring`
    , `multipoint`
    , `multipolygon`
    , `point`
    , `polygon`
    , `set`
    , `smallint`
    , `text`
    , `time`
    , `time3`
    , `time6`
    , `timestamp`
    , `timestamp3`
    , `timestamp6`
    , `tinyblob`
    , `tinyint`
    , `tinytext`
    , `varbinary`
    , `varchar`
    , `year`
    );

END
//

CREATE PROCEDURE s13.usp_datatypes_update (
    `id` INT
    , `bigint` BIGINT
    , `binary` BINARY(8)
    , `binary16` BINARY(16)
    , `bit1` BIT(1)
    , `bit3` BIT(3)
    , `blob` BLOB
    , `char` CHAR(10)
    , `char36` CHAR(36)
    , `date` DATE
    , `datetime` DATETIME
    , `datetime3` DATETIME(3)
    , `datetime6` DATETIME(6)
    , `decimal152` DECIMAL(15,2)
    , `decimal194` DECIMAL(19,4)
    , `double` DOUBLE
    , `enum` ENUM('x-small', 'small', 'medium', 'large', 'x-large')
    , `float` FLOAT
    , `geometry` GEOMETRY
    , `geometrycollection` GEOMETRYCOLLECTION
    , `int` INT
    , `json` JSON
    , `linestring` LINESTRING
    , `longblob` LONGBLOB
    , `longtext` LONGTEXT
    , `mediumblob` MEDIUMBLOB
    , `mediumint` MEDIUMINT
    , `mediumtext` MEDIUMTEXT
    , `multilinestring` MULTILINESTRING
    , `multipoint` MULTIPOINT
    , `multipolygon` MULTIPOLYGON
    , `point` POINT
    , `polygon` POLYGON
    , `set` SET('a', 'b', 'c', 'd')
    , `smallint` SMALLINT
    , `text` TEXT
    , `time` TIME
    , `time3` TIME(3)
    , `time6` TIME(6)
    , `timestamp` TIMESTAMP
    , `timestamp3` TIMESTAMP(3)
    , `timestamp6` TIMESTAMP(6)
    , `tinyblob` TINYBLOB
    , `tinyint` TINYINT
    , `tinytext` TINYTEXT
    , `varbinary` VARBINARY(1024)
    , `varchar` VARCHAR(255)
    , `year` YEAR
    )
BEGIN

UPDATE s13.datatypes t
SET
    t.`bigint` = `bigint`
    , t.`binary` = `binary`
    , t.`binary16` = `binary16`
    , t.`bit1` = `bit1`
    , t.`bit3` = `bit3`
    , t.`blob` = `blob`
    , t.`char` = `char`
    , t.`char36` = `char36`
    , t.`date` = `date`
    , t.`datetime` = `datetime`
    , t.`datetime3` = `datetime3`
    , t.`datetime6` = `datetime6`
    , t.`decimal152` = `decimal152`
    , t.`decimal194` = `decimal194`
    , t.`double` = `double`
    , t.`enum` = `enum`
    , t.`float` = `float`
    , t.`geometry` = `geometry`
    , t.`geometrycollection` = `geometrycollection`
    , t.`int` = `int`
    , t.`json` = `json`
    , t.`linestring` = `linestring`
    , t.`longblob` = `longblob`
    , t.`longtext` = `longtext`
    , t.`mediumblob` = `mediumblob`
    , t.`mediumint` = `mediumint`
    , t.`mediumtext` = `mediumtext`
    , t.`multilinestring` = `multilinestring`
    , t.`multipoint` = `multipoint`
    , t.`multipolygon` = `multipolygon`
    , t.`point` = `point`
    , t.`polygon` = `polygon`
    , t.`set` = `set`
    , t.`smallint` = `smallint`
    , t.`text` = `text`
    , t.`time` = `time`
    , t.`time3` = `time3`
    , t.`time6` = `time6`
    , t.`timestamp` = `timestamp`
    , t.`timestamp3` = `timestamp3`
    , t.`timestamp6` = `timestamp6`
    , t.`tinyblob` = `tinyblob`
    , t.`tinyint` = `tinyint`
    , t.`tinytext` = `tinytext`
    , t.`varbinary` = `varbinary`
    , t.`varchar` = `varchar`
    , t.`year` = `year`
WHERE
    t.`id` = `id`;

END
//

CREATE PROCEDURE s13.usp_odbc_datatypes (
    )
BEGIN

SELECT
    t.`id`
    , t.`bigint`
    , HEX(t.`binary`) AS `binary`
    , HEX(t.`binary16`) AS `binary16`
    , t.`bit1`
    , CAST(t.`bit3` AS unsigned) AS `bit3`
    , HEX(t.`blob`) AS `blob`
    , t.`char`
    , t.`char36`
    , t.`date`
    , t.`datetime`
    , CAST(t.`datetime3` AS char) AS `datetime3`
    , CAST(t.`datetime6` AS char) AS `datetime6`
    , t.`decimal152`
    , CAST(t.`decimal194` AS char) AS `decimal194`
    , t.`double`
    , t.`enum`
    , t.`float`
    , ST_AsText(t.`geometry`) AS `geometry`
    , ST_AsText(t.`geometrycollection`) AS `geometrycollection`
    , t.`int`
    , CAST(t.`json` AS char) AS `json`
    , ST_AsText(t.`linestring`) AS `linestring`
    , HEX(t.`longblob`) AS `longblob`
    , t.`longtext`
    , HEX(t.`mediumblob`) AS `mediumblob`
    , t.`mediumint`
    , t.`mediumtext`
    , ST_AsText(t.`multilinestring`) AS `multilinestring`
    , ST_AsText(t.`multipoint`) AS `multipoint`
    , ST_AsText(t.`multipolygon`) AS `multipolygon`
    , ST_AsText(t.`point`) AS `point`
    , ST_AsText(t.`polygon`) AS `polygon`
    , t.`set`
    , t.`smallint`
    , t.`text`
    , t.`time`
    , CAST(t.`time3` AS char) AS `time3`
    , CAST(t.`time6` AS char) AS `time6`
    , t.`timestamp`
    , CAST(t.`timestamp3` AS char) AS `timestamp3`
    , CAST(t.`timestamp6` AS char) AS `timestamp6`
    , HEX(t.`tinyblob`) AS `tinyblob`
    , t.`tinyint`
    , t.`tinytext`
    , HEX(t.`varbinary`) AS `varbinary`
    , t.`varchar`
    , t.`year`
FROM
    s13.datatypes t;

END
//

CREATE PROCEDURE s13.usp_odbc_datatypes_delete (
    `id` INT
    )
BEGIN

DELETE FROM s13.datatypes
WHERE
    s13.datatypes.`id` = `id`;

END
//

CREATE PROCEDURE s13.usp_odbc_datatypes_insert (
    `bigint` BIGINT
    , `binary` BINARY(8)
    , `binary16` BINARY(16)
    , `bit1` BIT(1)
    , `bit3` BIT(3)
    , `blob` BLOB
    , `char` CHAR(10)
    , `char36` CHAR(36)
    , `date` DATE
    , `datetime` DATETIME
    , `datetime3` DATETIME(3)
    , `datetime6` DATETIME(6)
    , `decimal152` DECIMAL(15,2)
    , `decimal194` DECIMAL(19,4)
    , `double` DOUBLE
    , `enum` ENUM('x-small', 'small', 'medium', 'large', 'x-large')
    , `float` FLOAT
    , `geometry` GEOMETRY
    , `geometrycollection` GEOMETRYCOLLECTION
    , `int` INT
    , `json` JSON
    , `linestring` LINESTRING
    , `longblob` LONGBLOB
    , `longtext` LONGTEXT
    , `mediumblob` MEDIUMBLOB
    , `mediumint` MEDIUMINT
    , `mediumtext` MEDIUMTEXT
    , `multilinestring` MULTILINESTRING
    , `multipoint` MULTIPOINT
    , `multipolygon` MULTIPOLYGON
    , `point` POINT
    , `polygon` POLYGON
    , `set` SET('a', 'b', 'c', 'd')
    , `smallint` SMALLINT
    , `text` TEXT
    , `time` TIME
    , `time3` TIME(3)
    , `time6` TIME(6)
    , `timestamp` TIMESTAMP
    , `timestamp3` TIMESTAMP(3)
    , `timestamp6` TIMESTAMP(6)
    , `tinyblob` TINYBLOB
    , `tinyint` TINYINT
    , `tinytext` TINYTEXT
    , `varbinary` VARBINARY(1024)
    , `varchar` VARCHAR(255)
    , `year` YEAR
    )
BEGIN

INSERT INTO s13.datatypes
    ( `bigint`
    , `binary`
    , `binary16`
    , `bit1`
    , `bit3`
    , `blob`
    , `char`
    , `char36`
    , `date`
    , `datetime`
    , `datetime3`
    , `datetime6`
    , `decimal152`
    , `decimal194`
    , `double`
    , `enum`
    , `float`
    , `geometry`
    , `geometrycollection`
    , `int`
    , `json`
    , `linestring`
    , `longblob`
    , `longtext`
    , `mediumblob`
    , `mediumint`
    , `mediumtext`
    , `multilinestring`
    , `multipoint`
    , `multipolygon`
    , `point`
    , `polygon`
    , `set`
    , `smallint`
    , `text`
    , `time`
    , `time3`
    , `time6`
    , `timestamp`
    , `timestamp3`
    , `timestamp6`
    , `tinyblob`
    , `tinyint`
    , `tinytext`
    , `varbinary`
    , `varchar`
    , `year`
    )
VALUES
    ( `bigint`
    , `binary`
    , `binary16`
    , `bit1`
    , `bit3`
    , `blob`
    , `char`
    , `char36`
    , `date`
    , `datetime`
    , `datetime3`
    , `datetime6`
    , `decimal152`
    , `decimal194`
    , `double`
    , `enum`
    , `float`
    , `geometry`
    , `geometrycollection`
    , `int`
    , `json`
    , `linestring`
    , `longblob`
    , `longtext`
    , `mediumblob`
    , `mediumint`
    , `mediumtext`
    , `multilinestring`
    , `multipoint`
    , `multipolygon`
    , `point`
    , `polygon`
    , `set`
    , `smallint`
    , `text`
    , `time`
    , `time3`
    , `time6`
    , `timestamp`
    , `timestamp3`
    , `timestamp6`
    , `tinyblob`
    , `tinyint`
    , `tinytext`
    , `varbinary`
    , `varchar`
    , `year`
    );

END
//

CREATE PROCEDURE s13.usp_odbc_datatypes_update (
    `id` INT
    , `bigint` BIGINT
    , `binary` BINARY(8)
    , `binary16` BINARY(16)
    , `bit1` BIT(1)
    , `bit3` BIT(3)
    , `blob` BLOB
    , `char` CHAR(10)
    , `char36` CHAR(36)
    , `date` DATE
    , `datetime` DATETIME
    , `datetime3` DATETIME(3)
    , `datetime6` DATETIME(6)
    , `decimal152` DECIMAL(15,2)
    , `decimal194` DECIMAL(19,4)
    , `double` DOUBLE
    , `enum` ENUM('x-small', 'small', 'medium', 'large', 'x-large')
    , `float` FLOAT
    , `geometry` GEOMETRY
    , `geometrycollection` GEOMETRYCOLLECTION
    , `int` INT
    , `json` JSON
    , `linestring` LINESTRING
    , `longblob` LONGBLOB
    , `longtext` LONGTEXT
    , `mediumblob` MEDIUMBLOB
    , `mediumint` MEDIUMINT
    , `mediumtext` MEDIUMTEXT
    , `multilinestring` MULTILINESTRING
    , `multipoint` MULTIPOINT
    , `multipolygon` MULTIPOLYGON
    , `point` POINT
    , `polygon` POLYGON
    , `set` SET('a', 'b', 'c', 'd')
    , `smallint` SMALLINT
    , `text` TEXT
    , `time` TIME
    , `time3` TIME(3)
    , `time6` TIME(6)
    , `timestamp` TIMESTAMP
    , `timestamp3` TIMESTAMP(3)
    , `timestamp6` TIMESTAMP(6)
    , `tinyblob` TINYBLOB
    , `tinyint` TINYINT
    , `tinytext` TINYTEXT
    , `varbinary` VARBINARY(1024)
    , `varchar` VARCHAR(255)
    , `year` YEAR
    )
BEGIN

UPDATE s13.datatypes t
SET
    t.`bigint` = `bigint`
    , t.`binary` = `binary`
    , t.`binary16` = `binary16`
    , t.`bit1` = `bit1`
    , t.`bit3` = `bit3`
    , t.`blob` = `blob`
    , t.`char` = `char`
    , t.`char36` = `char36`
    , t.`date` = `date`
    , t.`datetime` = `datetime`
    , t.`datetime3` = `datetime3`
    , t.`datetime6` = `datetime6`
    , t.`decimal152` = `decimal152`
    , t.`decimal194` = `decimal194`
    , t.`double` = `double`
    , t.`enum` = `enum`
    , t.`float` = `float`
    , t.`geometry` = `geometry`
    , t.`geometrycollection` = `geometrycollection`
    , t.`int` = `int`
    , t.`json` = `json`
    , t.`linestring` = `linestring`
    , t.`longblob` = `longblob`
    , t.`longtext` = `longtext`
    , t.`mediumblob` = `mediumblob`
    , t.`mediumint` = `mediumint`
    , t.`mediumtext` = `mediumtext`
    , t.`multilinestring` = `multilinestring`
    , t.`multipoint` = `multipoint`
    , t.`multipolygon` = `multipolygon`
    , t.`point` = `point`
    , t.`polygon` = `polygon`
    , t.`set` = `set`
    , t.`smallint` = `smallint`
    , t.`text` = `text`
    , t.`time` = `time`
    , t.`time3` = `time3`
    , t.`time6` = `time6`
    , t.`timestamp` = `timestamp`
    , t.`timestamp3` = `timestamp3`
    , t.`timestamp6` = `timestamp6`
    , t.`tinyblob` = `tinyblob`
    , t.`tinyint` = `tinyint`
    , t.`tinytext` = `tinytext`
    , t.`varbinary` = `varbinary`
    , t.`varchar` = `varchar`
    , t.`year` = `year`
WHERE
    t.`id` = `id`;

END
//

DELIMITER ;

INSERT INTO `s13`.`datatypes` (`bigint`, `binary`, `binary16`, `bit1`, `bit3`, `blob`, `char`, `char36`, `date`, `datetime`, `datetime3`, `datetime6`, `decimal152`, `decimal194`, `double`, `enum`, `float`, `geometry`, `geometrycollection`, `int`, `json`, `linestring`, `longblob`, `longtext`, `mediumblob`, `mediumint`, `mediumtext`, `multilinestring`, `multipoint`, `multipolygon`, `point`, `polygon`, `set`, `smallint`, `text`, `time`, `time3`, `time6`, `timestamp`, `timestamp3`, `timestamp6`, `tinyblob`, `tinyint`, `tinytext`, `varbinary`, `varchar`, `year`) VALUES (123456789012345, X'0A0B0C0000000000', X'030201000504070608090A0B0C0D0E0F', 1, 7, X'0A0B0C', 'char', '00010203-0405-0607-0809-0a0b0c0d0e0f', '2021-12-10', '2021-12-10 15:12:11', '2021-12-10 15:20:10.123', '2021-12-10 15:20:10.123456', 123456789012.12, 123456789012345.1234, 123456789012.12, 'x-large', 123456, ST_GeometryFromText('POINT(10 10)'), ST_GeometryCollectionFromText('GEOMETRYCOLLECTION(POINT(10 10),POINT(30 30),LINESTRING(15 15,20 20))'), 1234567890, '[1, 2, 3]', ST_LineStringFromText('LINESTRING(0 0,10 10,20 25,50 60)'), X'0A0B0C', 'long text', X'0A0B0C', 8388607, 'medium text', ST_MultiLineStringFromText('MULTILINESTRING((10 10,11 11),(9 9,10 10))'), ST_MultiPointFromText('MULTIPOINT((0 0),(20 20),(60 60))'), ST_MultiPolygonFromText('MULTIPOLYGON(((0 0,10 0,10 10,0 10,0 0)),((5 5,7 5,7 7,5 7,5 5)))'), ST_PointFromText('POINT(15 20)'), ST_PolygonFromText('POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7,5 5))'), 'a,d', 32767, 'text', '15:20:10', '15:20:10.123', '15:20:10.123456', '2021-12-10 15:12:11', '2021-12-10 15:12:11.123', '2021-12-10 15:12:11.123456', X'0A0B0C', 127, 'tiny text', X'0A0B0C', 'varchar', 2021);
INSERT INTO `s13`.`datatypes` (`bigint`, `binary`, `binary16`, `bit1`, `bit3`, `blob`, `char`, `char36`, `date`, `datetime`, `datetime3`, `datetime6`, `decimal152`, `decimal194`, `double`, `enum`, `float`, `geometry`, `geometrycollection`, `int`, `json`, `linestring`, `longblob`, `longtext`, `mediumblob`, `mediumint`, `mediumtext`, `multilinestring`, `multipoint`, `multipolygon`, `point`, `polygon`, `set`, `smallint`, `text`, `time`, `time3`, `time6`, `timestamp`, `timestamp3`, `timestamp6`, `tinyblob`, `tinyint`, `tinytext`, `varbinary`, `varchar`, `year`) VALUES (123456789012345, X'0A0B0C0000000000', X'030201000504070608090A0B0C0D0E0F', 1, 7, X'0A0B0C', 'char', '00010203-0405-0607-0809-0a0b0c0d0e0f', '2021-12-10', '2021-12-10 15:12:11', '2021-12-10 15:20:10.123', '2021-12-10 15:20:10.123456', 123456789012.12, 123456789012345.1234, 123456789012.12, 'x-large', 123456, ST_GeometryFromText('POINT(10 10)'), ST_GeometryCollectionFromText('GEOMETRYCOLLECTION(POINT(10 10),POINT(30 30),LINESTRING(15 15,20 20))'), 1234567890, '[1, 2, 3]', ST_LineStringFromText('LINESTRING(0 0,10 10,20 25,50 60)'), X'0A0B0C', 'long text', X'0A0B0C', 8388607, 'medium text', ST_MultiLineStringFromText('MULTILINESTRING((10 10,11 11),(9 9,10 10))'), ST_MultiPointFromText('MULTIPOINT((0 0),(20 20),(60 60))'), ST_MultiPolygonFromText('MULTIPOLYGON(((0 0,10 0,10 10,0 10,0 0)),((5 5,7 5,7 7,5 7,5 5)))'), ST_PointFromText('POINT(15 20)'), ST_PolygonFromText('POLYGON((0 0,10 0,10 10,0 10,0 0),(5 5,7 5,7 7,5 7,5 5))'), 'a,d', 32767, 'text', '15:20:10', '15:20:10.123', '15:20:10.123456', '2021-12-10 15:12:11', '2021-12-10 15:12:11.123', '2021-12-10 15:12:11.123456', X'0A0B0C', 127, 'tiny text', X'0A0B0C', 'varchar', 2021);
INSERT INTO `s13`.`datatypes` (`bigint`, `binary`, `binary16`, `bit1`, `bit3`, `blob`, `char`, `char36`, `date`, `datetime`, `datetime3`, `datetime6`, `decimal152`, `decimal194`, `double`, `enum`, `float`, `geometry`, `geometrycollection`, `int`, `json`, `linestring`, `longblob`, `longtext`, `mediumblob`, `mediumint`, `mediumtext`, `multilinestring`, `multipoint`, `multipolygon`, `point`, `polygon`, `set`, `smallint`, `text`, `time`, `time3`, `time6`, `timestamp`, `timestamp3`, `timestamp6`, `tinyblob`, `tinyint`, `tinytext`, `varbinary`, `varchar`, `year`) VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO s13.quotes (`'`, `''`, `,`, `-`, `@`, `@@`, ````, ``````, `"`, `""`, `]`, `[`, `[]`, `+`, `%`, `%%`, `=`, `;`, `:`, `<>`, `&`, `.`, `..`) VALUES ('''', '''''', ',', '-', '@', '@@', '`', '``', NULL, '""', ']', '[', '[]', '+', '%', '%%', '=', ';', ':', '<>', '&', '.', '..');
INSERT INTO s13.quotes (`'`, `''`, `,`, `-`, `@`, `@@`, ````, ``````, `"`, `""`, `]`, `[`, `[]`, `+`, `%`, `%%`, `=`, `;`, `:`, `<>`, `&`, `.`, `..`) VALUES ('1', '2', '3', '4', '5', '6', '`', '``', NULL, '""', ']', '[', '[]', '+', '%', '%%', '=', ';', ':', '<>', '&', '.', '..');

-- print Application installed
