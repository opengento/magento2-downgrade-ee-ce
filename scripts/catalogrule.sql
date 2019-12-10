-- Enable `rule_id` column for catalogrule

ALTER TABLE `catalogrule_customer_group`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Rule ID';
ALTER TABLE `catalogrule_website`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Rule ID';

-- Clean duplicates for catalogrule

DELETE e
FROM `catalogrule` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `rule_id`
    FROM `catalogrule`
    GROUP BY `rule_id`
) AS p
                         ON e.`rule_id` = p.`rule_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

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
    DROP FOREIGN KEY IF EXISTS `CATALOGRULE_CUSTOMER_GROUP_ROW_ID_CATALOGRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`, `customer_group_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Website
ALTER TABLE `catalogrule_website`
    DROP FOREIGN KEY IF EXISTS `CATALOGRULE_WEBSITE_ROW_ID_CATALOGRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`, `website_id`),
    DROP COLUMN `row_id`;

-- Catalogrule
ALTER TABLE `catalogrule`
    DROP FOREIGN KEY IF EXISTS `CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE`,
    DROP COLUMN IF EXISTS `row_id`,
    DROP COLUMN IF EXISTS `created_in`,
    DROP COLUMN IF EXISTS `updated_in`,
    ADD PRIMARY KEY (`rule_id`),
    MODIFY COLUMN `rule_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Rule ID';

-- Foreign keys
ALTER TABLE `catalogrule_customer_group`
    ADD CONSTRAINT `CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalogrule_website`
    ADD CONSTRAINT `CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

DROP TABLE IF EXISTS `magento_banner_catalogrule`, `sequence_catalogrule`;
