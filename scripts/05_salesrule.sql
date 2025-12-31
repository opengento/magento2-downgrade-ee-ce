--
-- 05_salesrule.sql
-- 

--
-- This procedure will give you the ability to drop a foreign key if it exists which MySQL/MariaDB can't do on its own.
-- Taken from: https://stackoverflow.com/questions/17161496/drop-foreign-key-only-if-it-exists
--
DROP PROCEDURE IF EXISTS PROC_DROP_FOREIGN_KEY;
DELIMITER $$
CREATE PROCEDURE PROC_DROP_FOREIGN_KEY(IN tableName VARCHAR(64), IN constraintName VARCHAR(64))
BEGIN
    IF EXISTS(
        SELECT * FROM information_schema.table_constraints
        WHERE 
            table_schema    = DATABASE()     AND
            table_name      = tableName      AND
            constraint_name = constraintName AND
            constraint_type = 'FOREIGN KEY')
    THEN
        SET @query = CONCAT('ALTER TABLE ', tableName, ' DROP FOREIGN KEY ', constraintName, ';');
        PREPARE stmt FROM @query; 
        EXECUTE stmt; 
        DEALLOCATE PREPARE stmt; 
    END IF; 
END$$
DELIMITER ;



DROP TABLE IF EXISTS
    `magento_banner_salesrule`,
    `magento_reward_salesrule`,
    `magento_salesrule_filter`,
    `magento_reminder_rule_coupon`,
    `magento_reminder_rule_website`,
    `magento_reminder_template`,
    `magento_reminder_rule_log`,
    `magento_reminder_rule`;

-- Enable `rule_id` column for salesrule

ALTER TABLE `salesrule_customer_group`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';
ALTER TABLE `salesrule_website`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';
ALTER TABLE `salesrule_product_attribute`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';
ALTER TABLE `salesrule_label`
    ADD COLUMN `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';

-- Clean duplicates for salesrule

DELETE e
FROM `salesrule` e
WHERE e.created_in > UNIX_TIMESTAMP() OR e.updated_in <= UNIX_TIMESTAMP();
UPDATE `salesrule`
SET
    from_date=IF(created_in = 1, from_date, DATE(FROM_UNIXTIME(created_in))),
    to_date=IF(updated_in = 2147483647, to_date, DATE(FROM_UNIXTIME(updated_in)))
WHERE rule_id=rule_id;

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
UPDATE `salesrule_label` v INNER JOIN `salesrule` e ON v.`row_id` = e.`row_id`
SET v.`rule_id` = e.`rule_id`
WHERE 1;

-- -----------------------------------------------------
-- Update the `rule_id` relation link for salesrule --
-- -----------------------------------------------------

-- Customer group
ALTER TABLE `salesrule_customer_group`
    DROP FOREIGN KEY `SALESRULE_CUSTOMER_GROUP_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`customer_group_id`),
    DROP COLUMN `row_id`;

-- Website
ALTER TABLE `salesrule_website`
    DROP FOREIGN KEY `SALESRULE_WEBSITE_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`website_id`),
    DROP COLUMN `row_id`;

-- Product Attribute
ALTER TABLE `salesrule_product_attribute`
    DROP FOREIGN KEY `SALESRULE_PRODUCT_ATTRIBUTE_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
    DROP COLUMN `row_id`;

-- Clean any orphans
DELETE FROM salesrule_label WHERE rule_id = 0;

-- Label Attribute
ALTER TABLE `salesrule_label`
    DROP FOREIGN KEY `SALESRULE_LABEL_ROW_ID_SALESRULE_ROW_ID`,
    DROP PRIMARY KEY,  ADD PRIMARY KEY (`label_id`),
    DROP KEY `SALESRULE_LABEL_ROW_ID_STORE_ID`, ADD UNIQUE KEY `SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`, `store_id`),
    DROP COLUMN `row_id`;

-- Salesrule
CALL PROC_DROP_FOREIGN_KEY("salesrule_label", "SALESRULE_LABEL_ROW_ID_SALESRULE_ROW_ID");

-- Amasty related
CALL PROC_DROP_FOREIGN_KEY("amasty_ampromo_rule", "AMASTY_AMPROMO_RULE_SALESRULE_ID_SALESRULE_ROW_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_amrules_rule", "AMASTY_AMRULES_RULE_SALESRULE_ID_SALESRULE_ROW_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_amrules_usage_limit", "AMASTY_AMRULES_USAGE_LIMIT_SALESRULE_ID_SALESRULE_ROW_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_free_gift_timer_timer_data", "AMASTY_FREE_GIFT_TIMER_TIMER_DATA_SALESRULE_ID_SALESRULE_ROW_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_amrules_usage_counter", "AMASTY_AMRULES_USAGE_COUNTER_SALESRULE_ID_SALESRULE_RULE_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_banners_lite_banner_data", "AMASTY_BANNERS_LITE_BANNER_DATA_SALESRULE_ID_SALESRULE_RULE_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_banners_lite_rule", "AMASTY_BANNERS_LITE_RULE_SALESRULE_ID_SALESRULE_ROW_ID");
CALL PROC_DROP_FOREIGN_KEY("amasty_banners_lite_rule", "AMASTY_BANNERS_LITE_RULE_SALESRULE_ID_SALESRULE_RULE_ID");

ALTER TABLE `salesrule`
    DROP FOREIGN KEY `SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`,
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
-- We need to clean up the salesrule_coupon table before dropping the sequence_salesrule table
DELETE FROM salesrule_coupon
    WHERE rule_id NOT IN (SELECT rule_id FROM salesrule);

ALTER TABLE `salesrule_coupon`
    DROP FOREIGN KEY `SALESRULE_COUPON_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    ADD CONSTRAINT `SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);
ALTER TABLE `salesrule_customer`
    DROP FOREIGN KEY `SALESRULE_CUSTOMER_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`,
    ADD CONSTRAINT `SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);

--
-- Already done above in line 103.
--
-- ALTER TABLE `salesrule_label`
--     CHANGE `row_id` `rule_id` INT(10) UNSIGNED NOT NULL COMMENT 'Rule ID';

DELETE FROM salesrule_label
    WHERE rule_id NOT IN (SELECT rule_id FROM salesrule);

ALTER TABLE `salesrule_label`
    ADD CONSTRAINT `SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`);

DROP TABLE `sequence_salesrule`;
