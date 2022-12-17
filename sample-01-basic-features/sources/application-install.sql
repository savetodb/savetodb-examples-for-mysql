-- =============================================
-- Application: Sample 01 - Basic SaveToDB Features
-- Version 10.6, December 13, 2022
--
-- Copyright 2014-2022 Gartle LLC
--
-- License: MIT
-- =============================================

CREATE SCHEMA s01 DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;

CREATE TABLE s01.cashbook (
  id int NOT NULL AUTO_INCREMENT,
  date datetime DEFAULT NULL,
  account varchar(50) DEFAULT NULL,
  item varchar(50) DEFAULT NULL,
  company varchar(50) DEFAULT NULL,
  debit double DEFAULT NULL,
  credit double DEFAULT NULL,
  CONSTRAINT PK_cashbook PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS s01.formats (
    ID INT NOT NULL AUTO_INCREMENT,
    TABLE_SCHEMA VARCHAR(64) NOT NULL,
    TABLE_NAME VARCHAR(64) NOT NULL,
    TABLE_EXCEL_FORMAT_XML MEDIUMTEXT,
    PRIMARY KEY (ID)
);

ALTER TABLE s01.formats ADD UNIQUE INDEX ix_formats USING BTREE (TABLE_SCHEMA, TABLE_NAME);

CREATE TABLE IF NOT EXISTS s01.workbooks (
    ID INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(128) NOT NULL,
    TEMPLATE VARCHAR(255),
    DEFINITION MEDIUMTEXT NOT NULL,
    TABLE_SCHEMA VARCHAR(64),
    PRIMARY KEY (ID)
);

ALTER TABLE s01.workbooks ADD UNIQUE INDEX IX_workbooks USING BTREE (NAME);

CREATE VIEW s01.view_cashbook
AS
SELECT
    p.id
    , p.date
    , p.account
    , p.item
    , p.company
    , p.debit
    , p.credit
FROM
    s01.cashbook p
;

DELIMITER //

CREATE PROCEDURE s01.usp_cashbook (
    account varchar(50)
    , item varchar(50)
    , company varchar(50)
    )
SQL SECURITY INVOKER
BEGIN
SELECT
    *
FROM
    s01.cashbook p
WHERE
    COALESCE(account, p.account, '') = COALESCE(p.account, '')
    AND COALESCE(item, p.item, '') = COALESCE(p.item, '')
    AND COALESCE(company, p.company, '') = COALESCE(p.company, '');

END
//

CREATE PROCEDURE s01.usp_cashbook2 (
    account varchar(50)
    , item varchar(50)
    , company varchar(50)
    )
BEGIN
SELECT
    *
FROM
    s01.cashbook p
WHERE
    COALESCE(account, p.account, '') = COALESCE(p.account, '')
    AND COALESCE(item, p.item, '') = COALESCE(p.item, '')
    AND COALESCE(company, p.company, '') = COALESCE(p.company, '');

END
//

CREATE PROCEDURE s01.usp_cashbook3 (
    account varchar(50)
    , item varchar(50)
    , company varchar(50)
    )
BEGIN
SELECT
    *
FROM
    s01.cashbook p
WHERE
    COALESCE(account, p.account, '') = COALESCE(p.account, '')
    AND COALESCE(item, p.item, '') = COALESCE(p.item, '')
    AND COALESCE(company, p.company, '') = COALESCE(p.company, '');

END
//

CREATE PROCEDURE s01.usp_cashbook4 (
    account varchar(50)
    , item varchar(50)
    , company varchar(50)
    )
BEGIN
SELECT
    *
FROM
    s01.cashbook p
WHERE
    COALESCE(account, p.account, '') = COALESCE(p.account, '')
    AND COALESCE(item, p.item, '') = COALESCE(p.item, '')
    AND COALESCE(company, p.company, '') = COALESCE(p.company, '');

END
//

CREATE PROCEDURE s01.usp_cashbook2_insert (
    date date
    , account varchar(50)
    , item varchar(50)
    , company varchar(50)
    , debit double
    , credit double
    )
BEGIN
INSERT INTO s01.cashbook
    ( date
    , account
    , item
    , company
    , debit
    , credit
    )
VALUES
    ( date
    , account
    , item
    , company
    , debit
    , credit
    );
END
//

CREATE PROCEDURE s01.usp_cashbook2_update (
    id int
    , date date
    , account varchar(50)
    , item varchar(50)
    , company varchar(50)
    , debit double
    , credit double
    )
BEGIN
UPDATE s01.cashbook t
SET
    t.date = date
    , t.account = account
    , t.item = item
    , t.company = company
    , t.debit = debit
    , t.credit = credit
WHERE
    t.id = id;
END
//

CREATE PROCEDURE s01.usp_cashbook2_delete (
    id int
    )
BEGIN
DELETE FROM s01.cashbook
WHERE
    s01.cashbook.id = id;
END
//

CREATE PROCEDURE s01.usp_cashbook3_change (
    column_name varchar(128)
    , cell_value varchar(255)
    , cell_number_value varchar(255)
    , cell_datetime_value varchar(255)
    , changed_cell_ction varchar(255)
    , changed_cell_count int
    , changed_cell_index int
    , data_language varchar(10)
    , id int
    , date date
    , account varchar(50)
    , item varchar(50)
    , company varchar(50)
    , debit double
    , credit double
    )
BEGIN
IF column_name = 'date' THEN
    UPDATE s01.cashbook t SET date = cell_datetime_value WHERE t.id = id;

ELSEIF column_name = 'account' THEN
    UPDATE s01.cashbook t SET account = cell_value WHERE t.id = id;

ELSEIF column_name = 'item' THEN
    UPDATE s01.cashbook t SET item = cell_value WHERE t.id = id;

ELSEIF column_name = 'company' THEN
    UPDATE s01.cashbook t SET company = cell_value WHERE t.id = id;

ELSEIF column_name = 'debit' THEN
    UPDATE s01.cashbook t SET debit = cell_number_value WHERE t.id = id;

ELSEIF column_name = 'credit' THEN
    UPDATE s01.cashbook t SET credit = cell_number_value WHERE t.id = id;

END IF;

END
//

CREATE PROCEDURE s01.usp_cashbook4_merge (
    id int
    , date date
    , account varchar(50)
    , item varchar(50)
    , company varchar(50)
    , debit double
    , credit double
    )
BEGIN
INSERT INTO s01.cashbook
    ( id
    , date
    , account
    , item
    , company
    , debit
    , credit
    )
VALUES
    ( id
    , date
    , account
    , item
    , company
    , debit
    , credit
    )
ON DUPLICATE KEY UPDATE
    date = date
    , account = account
    , item = item
    , company = company
    , debit = debit
    , credit = credit;
END
//

CREATE PROCEDURE s01.usp_cash_by_months (
    `Year` smallint
    )
BEGIN

SET @row_number = 0;

SELECT
    (@row_number:=@row_number + 1) AS sort_order
    -- row_number() OVER (ORDER BY p.section, p.item, p.company) AS sort_order
    , p.*
FROM
    (
SELECT
    p.section
    , MAX(p.level) AS level
    , p.item
    , p.company
    , MAX(CASE WHEN p.company IS NOT NULL THEN CONCAT('  ', p.name) ELSE p.name END) AS `Name`
    , SUM(CASE WHEN p.section = 1 THEN p.`Jan` WHEN p.section = 5 THEN p.`Dec` ELSE p.total END) AS `Total`
    , SUM(p.`Jan`) AS `Jan`
    , SUM(p.`Feb`) AS `Feb`
    , SUM(p.`Mar`) AS `Mar`
    , SUM(p.`Apr`) AS `Apr`
    , SUM(p.`May`) AS `May`
    , SUM(p.`Jun`) AS `Jun`
    , SUM(p.`Jul`) AS `Jul`
    , SUM(p.`Aug`) AS `Aug`
    , SUM(p.`Sep`) AS `Sep`
    , SUM(p.`Oct`) AS `Oct`
    , SUM(p.`Nov`) AS `Nov`
    , SUM(p.`Dec`) AS `Dec`
FROM
    (
    SELECT
        p.section
        , 2 AS level
        , p.item
        , p.company
        , p.company AS name
        , p.period
        , SUM(p.amount) AS total
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS UNSIGNED) AS section
            , p.item
            , p.company
            , MONTH(p.date) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            s01.cashbook p
        WHERE
            p.company IS NOT NULL
            AND YEAR(p.date) = `Year`
        ) p
    GROUP BY
        p.section
        , p.item
        , p.company
        , p.period

    UNION ALL
    SELECT
        p.section
        , 1 AS level
        , p.item
        , NULL AS company
        , p.item AS name
        , p.period
        , SUM(p.amount) AS total
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS UNSIGNED) AS section
            , p.item
            , MONTH(p.date) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            s01.cashbook p
        WHERE
            p.item IS NOT NULL
            AND YEAR(p.date) = `Year`
        ) p
    GROUP BY
        p.section
        , p.item
        , p.period

    UNION ALL
    SELECT
        p.section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , MAX(p.name) AS name
        , p.period
        , SUM(p.amount) AS total
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            CAST(CASE WHEN p.credit IS NOT NULL THEN 3 ELSE 2 END AS UNSIGNED) AS section
            , CASE WHEN p.credit IS NOT NULL THEN 'Total Expenses' ELSE 'Total Income' END AS name
            , MONTH(p.date) AS period
            , CASE WHEN p.credit IS NOT NULL THEN COALESCE(p.credit, 0) - COALESCE(p.debit, 0) ELSE COALESCE(p.debit, 0) - COALESCE(p.credit, 0) END AS amount
        FROM
            s01.cashbook p
        WHERE
            YEAR(p.date) = `Year`
        ) p
    GROUP BY
        p.section
        , p.period

    UNION ALL
    SELECT
        4 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Net Change' AS name
        , p.period
        , SUM(p.amount) AS total
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            MONTH(p.date) AS period
            , COALESCE(p.debit, 0) - COALESCE(p.credit, 0) AS amount
        FROM
            s01.cashbook p
        WHERE
            YEAR(p.date) = `Year`
        ) p
    GROUP BY
        p.period

    UNION ALL
    SELECT
        1 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Opening Balance' AS name
        , p.period
        , NULL AS total
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            MONTH(d.date) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            s01.cashbook p
            CROSS JOIN (
                SELECT MAKEDATE(`Year`, 1) AS date
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 1 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 2 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 3 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 4 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 5 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 6 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 7 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 8 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 9 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 10 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 11 MONTH)
            ) d
        WHERE
            p.date < d.date
        GROUP BY
            d.date
        ) p
    GROUP BY
        p.period

    UNION ALL
    SELECT
        5 AS section
        , 0 AS level
        , NULL AS item
        , NULL AS company
        , 'Closing Balance' AS name
        , p.period
        , NULL AS total
        , SUM(CASE p.period WHEN  2 THEN p.amount ELSE NULL END) AS `Jan`
        , SUM(CASE p.period WHEN  3 THEN p.amount ELSE NULL END) AS `Feb`
        , SUM(CASE p.period WHEN  4 THEN p.amount ELSE NULL END) AS `Mar`
        , SUM(CASE p.period WHEN  5 THEN p.amount ELSE NULL END) AS `Apr`
        , SUM(CASE p.period WHEN  6 THEN p.amount ELSE NULL END) AS `May`
        , SUM(CASE p.period WHEN  7 THEN p.amount ELSE NULL END) AS `Jun`
        , SUM(CASE p.period WHEN  8 THEN p.amount ELSE NULL END) AS `Jul`
        , SUM(CASE p.period WHEN  9 THEN p.amount ELSE NULL END) AS `Aug`
        , SUM(CASE p.period WHEN 10 THEN p.amount ELSE NULL END) AS `Sep`
        , SUM(CASE p.period WHEN 11 THEN p.amount ELSE NULL END) AS `Oct`
        , SUM(CASE p.period WHEN 12 THEN p.amount ELSE NULL END) AS `Nov`
        , SUM(CASE p.period WHEN  1 THEN p.amount ELSE NULL END) AS `Dec`
    FROM
        (
        SELECT
            MONTH(d.date) AS period
            , SUM(COALESCE(p.debit, 0) - COALESCE(p.credit, 0)) AS amount
        FROM
            s01.cashbook p
            CROSS JOIN (
                SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 1 MONTH) AS date
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 2 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 3 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 4 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 5 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 6 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 7 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 8 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 9 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 10 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 11 MONTH)
                UNION SELECT DATE_ADD(MAKEDATE(`Year`, 1), INTERVAL 12 MONTH)
            ) d
        WHERE
            p.date < d.date
        GROUP BY
            d.date
        ) p
    GROUP BY
        p.period
    ) p
GROUP BY
    p.section
    , p.item
    , p.company
) p
ORDER BY
    p.section
    , p.item
    , p.company;

END
//

CREATE PROCEDURE s01.usp_cash_by_months_change (
    column_name varchar(255)
    , cell_number_value double
    , section smallint
    , item varchar(50)
    , company varchar(50)
    , year smallint
    )
P1:BEGIN

DECLARE month int;
DECLARE start_date date;
DECLARE end_date date;
DECLARE id1 int;
DECLARE count1 int;
DECLARE date1 date;
DECLARE account1 varchar(50);
DECLARE item1 varchar(50);
DECLARE company1 varchar(50);

SET item1 = item;
SET company1 = company;

SET month = INSTR('    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ', CONCAT(' ', column_name, ' ')) / 4;

IF month < 1 THEN LEAVE P1; END IF;

IF year IS NULL THEN SELECT YEAR(MAX(date)) INTO year FROM s01.cashbook; END IF;
IF year IS NULL THEN SET year = YEAR(CURDATE()); END IF;

SET start_date = DATE(CONCAT_WS('-', year, month, 1));

SET end_date = DATE_ADD(DATE_ADD(DATE(CONCAT_WS('-', year, month, 1)), INTERVAL 1 MONTH), INTERVAL -1 DAY);

SELECT
    MAX(id), COUNT(*)
INTO
    id1, count1
FROM
    s01.cashbook t
WHERE
    t.item = item1 AND COALESCE(t.company, '') = COALESCE(company1, '') AND t.date BETWEEN start_date AND end_date;

IF count1 = 0 THEN

    IF item1 IS NULL THEN
        LEAVE P1;
    END IF;

    SELECT
        MAX(ID)
    INTO
        id1
    FROM
        s01.cashbook T
    WHERE
        t.item = item1 AND COALESCE(t.company, '') = COALESCE(company1, '') AND t.date < end_date;

    IF id1 IS NOT NULL THEN

        SELECT date, account INTO date1, account1 FROM s01.cashbook WHERE id = id1;

        IF DAY(date1) > DAY(end_date) THEN
            SET date1 = end_date;
        ELSE
            SET date1 = DATE(CONCAT_WS('-', year, month, DAY(date1)));
        END IF;
    ELSE
        SET date1 = end_date;
    END IF;

    INSERT INTO s01.cashbook (date, account, item, company, debit, credit)
        VALUES (date1, account1, item1, company1,
            CASE WHEN section = 3 THEN NULL ELSE cell_number_value END,
            CASE WHEN section = 3 THEN cell_number_value ELSE NULL END);

    LEAVE P1;
END IF;

IF count1 > 1 THEN
    LEAVE P1;
END IF;

UPDATE s01.cashbook
SET
    debit = CASE WHEN section = 3 THEN NULL ELSE cell_number_value END
    , credit = CASE WHEN section = 3 THEN cell_number_value ELSE NULL END
WHERE
    id = id1;

END
//

DELIMITER ;

INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (1,  '2022-01-10', 'Bank', 'Revenue', 'Customer C1', 200000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (2,  '2022-01-10', 'Bank', 'Expenses', 'Supplier S1', NULL, 50000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (3,  '2022-01-31', 'Bank', 'Payroll', NULL, NULL, 85000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (4,  '2022-01-31', 'Bank', 'Taxes', 'Individual Income Tax', NULL, 15000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (5,  '2022-01-31', 'Bank', 'Taxes', 'Payroll Taxes', NULL, 15000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (6,  '2022-02-10', 'Bank', 'Revenue', 'Customer C1', 300000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (7,  '2022-02-10', 'Bank', 'Revenue', 'Customer C2', 100000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (8,  '2022-02-10', 'Bank', 'Expenses', 'Supplier S1', NULL, 100000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (9,  '2022-02-10', 'Bank', 'Expenses', 'Supplier S2', NULL, 50000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (10, '2022-02-28', 'Bank', 'Payroll', NULL, NULL, 85000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (11, '2022-02-28', 'Bank', 'Taxes', 'Individual Income Tax', NULL, 15000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (12, '2022-02-28', 'Bank', 'Taxes', 'Payroll Taxes', NULL, 15000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (13, '2022-03-10', 'Bank', 'Revenue', 'Customer C1', 300000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (14, '2022-03-10', 'Bank', 'Revenue', 'Customer C2', 200000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (15, '2022-03-10', 'Bank', 'Revenue', 'Customer C3', 100000, NULL);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (16, '2022-03-15', 'Bank', 'Taxes', 'Corporate Income Tax', NULL, 100000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (17, '2022-03-31', 'Bank', 'Payroll', NULL, NULL, 170000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (18, '2022-03-31', 'Bank', 'Taxes', 'Individual Income Tax', NULL, 30000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (19, '2022-03-31', 'Bank', 'Taxes', 'Payroll Taxes', NULL, 30000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (20, '2022-03-31', 'Bank', 'Expenses', 'Supplier S1', NULL, 100000);
INSERT INTO s01.cashbook (id, date, account, item, company, debit, credit) VALUES (21, '2022-03-31', 'Bank', 'Expenses', 'Supplier S2', NULL, 50000);

INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'usp_cash_by_months', '<table name="s01.usp_cash_by_months"><columnFormats><column name="" property="ListObjectName" value="usp_cash_by_months" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium15" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="sort_order" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="sort_order" property="Address" value="$C$4" type="String"/><column name="sort_order" property="NumberFormat" value="General" type="String"/><column name="section" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="section" property="Address" value="$D$4" type="String"/><column name="section" property="NumberFormat" value="General" type="String"/><column name="level" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="level" property="Address" value="$E$4" type="String"/><column name="level" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Name" property="Address" value="$H$4" type="String"/><column name="Name" property="ColumnWidth" value="21.43" type="Double"/><column name="Name" property="NumberFormat" value="General" type="String"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="Address" value="$I$4" type="String"/><column name="Jan" property="ColumnWidth" value="10" type="Double"/><column name="Jan" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="Address" value="$J$4" type="String"/><column name="Feb" property="ColumnWidth" value="10" type="Double"/><column name="Feb" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="Address" value="$K$4" type="String"/><column name="Mar" property="ColumnWidth" value="10" type="Double"/><column name="Mar" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="Address" value="$L$4" type="String"/><column name="Apr" property="ColumnWidth" value="10" type="Double"/><column name="Apr" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="Address" value="$M$4" type="String"/><column name="May" property="ColumnWidth" value="10" type="Double"/><column name="May" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="Address" value="$N$4" type="String"/><column name="Jun" property="ColumnWidth" value="10" type="Double"/><column name="Jun" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="Address" value="$O$4" type="String"/><column name="Jul" property="ColumnWidth" value="10" type="Double"/><column name="Jul" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="Address" value="$P$4" type="String"/><column name="Aug" property="ColumnWidth" value="10" type="Double"/><column name="Aug" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="Address" value="$Q$4" type="String"/><column name="Sep" property="ColumnWidth" value="10" type="Double"/><column name="Sep" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="Address" value="$R$4" type="String"/><column name="Oct" property="ColumnWidth" value="10" type="Double"/><column name="Oct" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="Address" value="$S$4" type="String"/><column name="Nov" property="ColumnWidth" value="10" type="Double"/><column name="Nov" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="Address" value="$T$4" type="String"/><column name="Dec" property="ColumnWidth" value="10" type="Double"/><column name="Dec" property="NumberFormat" value="#,##0;[Red]-#,##0;" type="String"/><column name="_RowNum" property="FormatConditions(1).AppliesToTable" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(1).AppliesTo.Address" value="$B$4:$T$20" type="String"/><column name="_RowNum" property="FormatConditions(1).Type" value="2" type="Double"/><column name="_RowNum" property="FormatConditions(1).Priority" value="3" type="Double"/><column name="_RowNum" property="FormatConditions(1).Formula1" value="=$E4&lt;2" type="String"/><column name="_RowNum" property="FormatConditions(1).Font.Bold" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).AppliesToTable" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).AppliesTo.Address" value="$B$4:$T$20" type="String"/><column name="_RowNum" property="FormatConditions(2).Type" value="2" type="Double"/><column name="_RowNum" property="FormatConditions(2).Priority" value="4" type="Double"/><column name="_RowNum" property="FormatConditions(2).Formula1" value="=AND($E4=0,$D4&gt;1,$D4&lt;5)" type="String"/><column name="_RowNum" property="FormatConditions(2).Font.Bold" value="True" type="Boolean"/><column name="_RowNum" property="FormatConditions(2).Font.Color" value="16777215" type="Double"/><column name="_RowNum" property="FormatConditions(2).Font.ThemeColor" value="1" type="Double"/><column name="_RowNum" property="FormatConditions(2).Font.TintAndShade" value="0" type="Double"/><column name="_RowNum" property="FormatConditions(2).Interior.Color" value="6773025" type="Double"/><column name="_RowNum" property="FormatConditions(2).Interior.Color" value="6773025" type="Double"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All columns"><column name="" property="ListObjectName" value="cash_by_month" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="sort_order" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="section" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="level" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Default"><column name="" property="ListObjectName" value="cash_by_month" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="sort_order" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="section" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="level" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="Name" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jan" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Feb" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Mar" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Apr" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="May" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jun" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Jul" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Aug" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Sep" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Oct" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Nov" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="Dec" property="EntireColumn.Hidden" value="False" type="Boolean"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'cashbook', '<table name="s01.cashbook"><columnFormats><column name="" property="ListObjectName" value="cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'view_cashbook', '<table name="s01.view_cashbook"><columnFormats><column name="" property="ListObjectName" value="view_cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'usp_cashbook', '<table name="s01.usp_cashbook"><columnFormats><column name="" property="ListObjectName" value="usp_cashbook" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'usp_cashbook2', '<table name="s01.usp_cashbook2"><columnFormats><column name="" property="ListObjectName" value="usp_cashbook2" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'usp_cashbook3', '<table name="s01.usp_cashbook3"><columnFormats><column name="" property="ListObjectName" value="usp_cashbook3" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');
INSERT INTO s01.formats (TABLE_SCHEMA, TABLE_NAME, TABLE_EXCEL_FORMAT_XML) VALUES ('s01', 'usp_cashbook4', '<table name="s01.usp_cashbook4"><columnFormats><column name="" property="ListObjectName" value="usp_cashbook4" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="" property="TableStyle.Name" value="TableStyleMedium2" type="String"/><column name="" property="ShowTableStyleColumnStripes" value="False" type="Boolean"/><column name="" property="ShowTableStyleFirstColumn" value="False" type="Boolean"/><column name="" property="ShowShowTableStyleLastColumn" value="False" type="Boolean"/><column name="" property="ShowTableStyleRowStripes" value="True" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="_RowNum" property="Address" value="$B$4" type="String"/><column name="_RowNum" property="NumberFormat" value="General" type="String"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="id" property="Address" value="$C$4" type="String"/><column name="id" property="ColumnWidth" value="4.29" type="Double"/><column name="id" property="NumberFormat" value="General" type="String"/><column name="id" property="Validation.Type" value="1" type="Double"/><column name="id" property="Validation.Operator" value="1" type="Double"/><column name="id" property="Validation.Formula1" value="-2147483648" type="String"/><column name="id" property="Validation.Formula2" value="2147483647" type="String"/><column name="id" property="Validation.AlertStyle" value="1" type="Double"/><column name="id" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="id" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="id" property="Validation.ShowInput" value="True" type="Boolean"/><column name="id" property="Validation.ShowError" value="True" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="Address" value="$D$4" type="String"/><column name="date" property="ColumnWidth" value="11.43" type="Double"/><column name="date" property="NumberFormat" value="m/d/yyyy" type="String"/><column name="date" property="Validation.Type" value="4" type="Double"/><column name="date" property="Validation.Operator" value="5" type="Double"/><column name="date" property="Validation.Formula1" value="12/31/1899" type="String"/><column name="date" property="Validation.AlertStyle" value="1" type="Double"/><column name="date" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="date" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="date" property="Validation.ShowInput" value="True" type="Boolean"/><column name="date" property="Validation.ShowError" value="True" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="Address" value="$E$4" type="String"/><column name="account" property="ColumnWidth" value="12.14" type="Double"/><column name="account" property="NumberFormat" value="General" type="String"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="Address" value="$F$4" type="String"/><column name="item" property="ColumnWidth" value="20.71" type="Double"/><column name="item" property="NumberFormat" value="General" type="String"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="Address" value="$G$4" type="String"/><column name="company" property="ColumnWidth" value="20.71" type="Double"/><column name="company" property="NumberFormat" value="General" type="String"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="Address" value="$H$4" type="String"/><column name="debit" property="ColumnWidth" value="11.43" type="Double"/><column name="debit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="debit" property="Validation.Type" value="2" type="Double"/><column name="debit" property="Validation.Operator" value="4" type="Double"/><column name="debit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="debit" property="Validation.AlertStyle" value="1" type="Double"/><column name="debit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="debit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="debit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="debit" property="Validation.ShowError" value="True" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="Address" value="$I$4" type="String"/><column name="credit" property="ColumnWidth" value="11.43" type="Double"/><column name="credit" property="NumberFormat" value="#,##0.00_ ;[Red]-#,##0.00 " type="String"/><column name="credit" property="Validation.Type" value="2" type="Double"/><column name="credit" property="Validation.Operator" value="4" type="Double"/><column name="credit" property="Validation.Formula1" value="-1.11222333444555E+29" type="String"/><column name="credit" property="Validation.AlertStyle" value="1" type="Double"/><column name="credit" property="Validation.IgnoreBlank" value="True" type="Boolean"/><column name="credit" property="Validation.InCellDropdown" value="True" type="Boolean"/><column name="credit" property="Validation.ShowInput" value="True" type="Boolean"/><column name="credit" property="Validation.ShowError" value="True" type="Boolean"/><column name="" property="ActiveWindow.DisplayGridlines" value="False" type="Boolean"/><column name="" property="ActiveWindow.FreezePanes" value="True" type="Boolean"/><column name="" property="ActiveWindow.Split" value="True" type="Boolean"/><column name="" property="ActiveWindow.SplitRow" value="0" type="Double"/><column name="" property="ActiveWindow.SplitColumn" value="-2" type="Double"/><column name="" property="PageSetup.Orientation" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesWide" value="1" type="Double"/><column name="" property="PageSetup.FitToPagesTall" value="1" type="Double"/></columnFormats><views><view name="All rows"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/></view><view name="Incomes"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view><view name="Expenses"><column name="" property="ListObjectName" value="cash_book" type="String"/><column name="" property="ShowTotals" value="False" type="Boolean"/><column name="_RowNum" property="EntireColumn.Hidden" value="True" type="Boolean"/><column name="id" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="date" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="account" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="item" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="company" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="debit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="EntireColumn.Hidden" value="False" type="Boolean"/><column name="credit" property="AutoFilter.Criteria1" value="&lt;&gt;" type="String"/></view></views></table>');

INSERT INTO s01.workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 01 - Basic Features - User1.xlsx', 'https://www.savetodb.com/downloads/v10/sample01-user1.xlsx', '
cashbook=s01.cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"cashbook"}
view_cashbook=s01.view_cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"view_cashbook"}
usp_cashbook=s01.usp_cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook"}
usp_cashbook2=s01.usp_cashbook2,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook2"}
usp_cashbook3=s01.usp_cashbook3,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook3"}
usp_cashbook4=s01.usp_cashbook4,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook4"}
cash_by_months=s01.usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2021},"ListObjectName":"cash_by_months"}
', 's01');

INSERT INTO s01.workbooks (NAME, TEMPLATE, DEFINITION, TABLE_SCHEMA) VALUES ('Sample 01 - Basic Features - User2 (Restricted).xlsx', 'https://www.savetodb.com/downloads/v10/sample01-user2.xlsx', '
cashbook=s01.cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"cashbook"}
view_cashbook=s01.view_cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"view_cashbook"}
usp_cashbook=s01.usp_cashbook,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook"}
usp_cashbook2=s01.usp_cashbook2,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook2"}
usp_cashbook3=s01.usp_cashbook3,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook3"}
usp_cashbook4=s01.usp_cashbook4,(Default),False,$B$3,,{"Parameters":{"account":null,"item":null,"company":null},"ListObjectName":"usp_cashbook4"}
cash_by_months=s01.usp_cash_by_months,(Default),False,$B$3,,{"Parameters":{"year":2021},"ListObjectName":"cash_by_months"}
', 's01');

-- print Application installed
