-- Enable `entity_id` column for catalog category entity

ALTER TABLE `catalog_category_entity_datetime`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `catalog_category_entity_decimal`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `catalog_category_entity_int`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `catalog_category_entity_text`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `catalog_category_entity_varchar`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0;

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

-- ------------------------------------------------------------------
-- Update the `entity_id` relation link for catalog product entity --
-- ------------------------------------------------------------------

-- Datetime
ALTER TABLE `catalog_category_entity_datetime`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID;
DROP INDEX IF EXISTS CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_datetime`;
ALTER TABLE `catalog_category_entity_datetime`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_datetime`
    DROP COLUMN IF EXISTS `row_id`;

-- Decimal
ALTER TABLE `catalog_category_entity_decimal`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID;
DROP INDEX IF EXISTS CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_decimal`;
ALTER TABLE `catalog_category_entity_decimal`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_decimal`
    DROP COLUMN IF EXISTS `row_id`;

-- Int
ALTER TABLE `catalog_category_entity_int`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID;
DROP INDEX IF EXISTS CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_int`;
ALTER TABLE `catalog_category_entity_int`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_int`
    DROP COLUMN IF EXISTS `row_id`;

-- Text
ALTER TABLE `catalog_category_entity_text`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID;
DROP INDEX IF EXISTS CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_text`;
ALTER TABLE `catalog_category_entity_text`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_text`
    DROP COLUMN IF EXISTS `row_id`;

-- Varchar
ALTER TABLE `catalog_category_entity_varchar`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID;
DROP INDEX IF EXISTS CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_varchar`;
ALTER TABLE `catalog_category_entity_varchar`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_varchar`
    DROP COLUMN IF EXISTS `row_id`;

-- Entity
ALTER TABLE `catalog_category_entity`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_category_entity`
    DROP COLUMN IF EXISTS `row_id`,
    DROP COLUMN IF EXISTS `created_in`,
    DROP COLUMN IF EXISTS `updated_in`;
ALTER TABLE `catalog_category_entity`
    MODIFY COLUMN `entity_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `catalog_category_entity`
    ADD PRIMARY KEY (`entity_id`);

-- Foreign keys
ALTER TABLE `catalog_category_entity_datetime`
    ADD CONSTRAINT CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_decimal`
    ADD CONSTRAINT CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_int`
    ADD CONSTRAINT CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_text`
    ADD CONSTRAINT CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_category_entity_varchar`
    ADD CONSTRAINT CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `catalog_category_product`
    DROP FOREIGN KEY IF EXISTS CAT_CTGR_PRD_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_category_product`
    ADD CONSTRAINT CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_url_rewrite_product_category`
    DROP FOREIGN KEY IF EXISTS CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_url_rewrite_product_category`
    ADD CONSTRAINT CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

DROP TABLE IF EXISTS `magento_catalogevent_event_image`, `magento_catalogevent_event`, `sequence_catalog_category`;
