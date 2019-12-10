-- Enable `rule_id` column for salesrule

ALTER TABLE `salesrule_customer_group`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';
ALTER TABLE `salesrule_website`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';
ALTER TABLE `salesrule_product_attribute`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';

-- Clean duplicates for salesrule

DELETE e
FROM `salesrule` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`,`rule_id`
    FROM `salesrule`
    GROUP BY `rule_id`
) AS p
                         ON e.`rule_id` = p.`rule_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Populate `rule_id` column for salesrule

UPDATE `salesrule_customer_group` v INNER JOIN `salesrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;
UPDATE `salesrule_website` v INNER JOIN `salesrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;
UPDATE `salesrule_product_attribute` v INNER JOIN `salesrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;

-- -----------------------------------------------------
-- Update the `rule_id` relation link for salesrule --
-- -----------------------------------------------------

-- Customer group
ALTER TABLE `salesrule_customer_group`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_CUSTOMER_GROUP_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`customer_group_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Website
ALTER TABLE `salesrule_website`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_WEBSITE_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`customer_group_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Product Attribute
ALTER TABLE `salesrule_product_attribute`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_PRODUCT_ATTRIBUTE_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Salesrule
ALTER TABLE `salesrule`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    DROP COLUMN IF EXISTS `row_id`,
    DROP COLUMN IF EXISTS `created_in`,
    DROP COLUMN IF EXISTS `updated_in`,
    ADD PRIMARY KEY (`rule_id`),
    MODIFY COLUMN `rule_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Entity ID';

-- Foreign keys
ALTER TABLE `salesrule_customer_group`
    ADD CONSTRAINT `SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `salesrule_website`
    ADD CONSTRAINT `SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `salesrule_product_attribute`
    ADD CONSTRAINT `SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `salesrule_coupon`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_COUPON_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    ADD CONSTRAINT `SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);
ALTER TABLE `salesrule_customer`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_CUSTOMER_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    ADD CONSTRAINT `SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);
ALTER TABLE `salesrule_label`
    DROP FOREIGN KEY IF EXISTS `SALESRULE_LABEL_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    ADD CONSTRAINT `SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);

DROP TABLE IF EXISTS `magento_banner_salesrule`,`magento_reward_salesrule`,`magento_salesrule_filter`,`sequence_salesrule`;
