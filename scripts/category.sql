-- Enable `entity_id` column for catalog category entity
DELETE FROM catalog_category_entity WHERE row_id NOT IN (
    SELECT tmp_category.row_id FROM (SELECT MAX(row_id) AS row_id FROM catalog_category_entity GROUP BY entity_id) tmp_category
);

ALTER TABLE `catalog_category_entity_datetime`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_category_entity_decimal`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_category_entity_int`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_category_entity_text`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_category_entity_varchar`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';

-- Clean duplicates for catalog category entity

DELETE e
FROM `catalog_product_entity` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `entity_id`
    FROM `catalog_product_entity`
    GROUP BY `entity_id`
) AS p
                         ON e.`entity_id` = p.`entity_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Populate `entity_id` column for catalog category entity

UPDATE `catalog_category_entity_datetime` v INNER JOIN `catalog_category_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_category_entity_decimal` v INNER JOIN `catalog_category_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_category_entity_int` v INNER JOIN `catalog_category_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_category_entity_text` v INNER JOIN `catalog_category_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_category_entity_varchar` v INNER JOIN `catalog_category_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;

-- -------------------------------------------------------------------
-- Delete entities which does not exists in catalog_category_entity --
-- -------------------------------------------------------------------
DELETE FROM `catalog_category_entity_datetime` WHERE row_id NOT IN (SELECT MAX(row_id) FROM catalog_category_entity GROUP BY entity_id) ORDER BY `entity_id` ASC;

DELETE FROM `catalog_category_entity_decimal` WHERE row_id NOT IN (SELECT MAX(row_id) FROM catalog_category_entity GROUP BY entity_id) ORDER BY `entity_id` ASC;

DELETE FROM `catalog_category_entity_int` WHERE row_id NOT IN (SELECT MAX(row_id) FROM catalog_category_entity GROUP BY entity_id) ORDER BY `entity_id` ASC;

DELETE FROM `catalog_category_entity_text` WHERE row_id NOT IN (SELECT MAX(row_id) FROM catalog_category_entity GROUP BY entity_id) ORDER BY `entity_id` ASC;

DELETE FROM `catalog_category_entity_varchar` WHERE row_id NOT IN (SELECT MAX(row_id) FROM catalog_category_entity GROUP BY entity_id) ORDER BY `entity_id` ASC;

-- ------------------------------------------------------------------
-- Update the `entity_id` relation link for catalog product entity --
-- ------------------------------------------------------------------

-- Datetime
ALTER TABLE `catalog_category_entity_datetime`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
    DROP INDEX `CATALOG_CATEGORY_ENTITY_DATETIME_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
    ADD CONSTRAINT `CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN `row_id`;

-- Decimal
ALTER TABLE `catalog_category_entity_decimal`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
    DROP INDEX `CATALOG_CATEGORY_ENTITY_DECIMAL_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
    ADD CONSTRAINT `CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN `row_id`;

-- Int
ALTER TABLE `catalog_category_entity_int`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
    DROP INDEX `CATALOG_CATEGORY_ENTITY_INT_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
    ADD CONSTRAINT `CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN `row_id`;

-- Text
ALTER TABLE `catalog_category_entity_text`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
    DROP INDEX `CATALOG_CATEGORY_ENTITY_TEXT_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
    ADD CONSTRAINT `CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN `row_id`;

-- Varchar
ALTER TABLE `catalog_category_entity_varchar`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
    DROP INDEX `CATALOG_CATEGORY_ENTITY_VARCHAR_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
    ADD CONSTRAINT `CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN `row_id`;

-- Entity
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `catalog_category_entity`
    DROP FOREIGN KEY `CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL`,
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`,
    MODIFY COLUMN `entity_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
    ADD PRIMARY KEY (`entity_id`);
SET FOREIGN_KEY_CHECKS = 1;

-- Foreign keys
ALTER TABLE `catalog_category_entity_datetime`
    ADD CONSTRAINT `CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_decimal`
    ADD CONSTRAINT `CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_int`
    ADD CONSTRAINT `CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_text`
    ADD CONSTRAINT `CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_varchar`
    ADD CONSTRAINT `CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `catalog_category_product`
    DROP FOREIGN KEY `CAT_CTGR_PRD_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL`,
    ADD CONSTRAINT `CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_url_rewrite_product_category`
    DROP FOREIGN KEY `CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL`,
    ADD CONSTRAINT `CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

DROP TABLE `sequence_catalog_category`;
