-- Enable `rule_id` column for catalogrule

ALTER TABLE `catalogrule_customer_group`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Rule ID';
ALTER TABLE `catalogrule_website`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Rule ID';

-- Clean duplicates for catalogrule

DELETE e
FROM `catalogrule` e
WHERE e.created_in > UNIX_TIMESTAMP() OR e.updated_in <= UNIX_TIMESTAMP();
UPDATE `catalogrule`
SET
    from_date=IF(created_in = 1, from_date, DATE(FROM_UNIXTIME(created_in))),
    to_date=IF(updated_in = 2147483647, to_date, DATE(FROM_UNIXTIME(updated_in)))
WHERE rule_id=rule_id;

-- Populate `rule_id` column for catalogrule

UPDATE `catalogrule_customer_group` v INNER JOIN `catalogrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;
UPDATE `catalogrule_website` v INNER JOIN `catalogrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;

-- -----------------------------------------------------
-- Update the `rule_id` relation link for catalogrule --
-- -----------------------------------------------------

-- Customer group
ALTER TABLE `catalogrule_customer_group`
    DROP FOREIGN KEY `CATALOGRULE_CUSTOMER_GROUP_ROW_ID_CATALOGRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`customer_group_id`),
    DROP COLUMN `row_id`;

-- Website
ALTER TABLE `catalogrule_website`
    DROP FOREIGN KEY `CATALOGRULE_WEBSITE_ROW_ID_CATALOGRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`website_id`),
    DROP COLUMN `row_id`;

-- Catalogrule
ALTER TABLE `catalogrule`
    DROP FOREIGN KEY `CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE`,
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`,
    ADD PRIMARY KEY (`rule_id`),
    MODIFY COLUMN `rule_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Entity ID';

-- Foreign keys
ALTER TABLE `catalogrule_customer_group`
    ADD CONSTRAINT `CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalogrule_website`
    ADD CONSTRAINT `CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

DROP TABLE `sequence_catalogrule`;
