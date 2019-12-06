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
DROP INDEX CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_datetime`;
ALTER TABLE `catalog_category_entity_datetime`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_datetime`
    DROP COLUMN `row_id`;
ALTER TABLE `catalog_category_entity_datetime`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Decimal
DROP INDEX CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_decimal`;
ALTER TABLE `catalog_category_entity_decimal`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_decimal`
    DROP COLUMN `row_id`;
ALTER TABLE `catalog_category_entity_decimal`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Int
DROP INDEX CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_int`;
ALTER TABLE `catalog_category_entity_int`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_int`
    DROP COLUMN `row_id`;
ALTER TABLE `catalog_category_entity_int`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Text
DROP INDEX CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_text`;
ALTER TABLE `catalog_category_entity_text`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_text`
    DROP COLUMN `row_id`;
ALTER TABLE `catalog_category_entity_text`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Varchar
DROP INDEX CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID ON `catalog_category_entity_varchar`;
ALTER TABLE `catalog_category_entity_varchar`
    ADD CONSTRAINT CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`);
ALTER TABLE `catalog_category_entity_varchar`
    DROP COLUMN `row_id`;
ALTER TABLE `catalog_category_entity_varchar`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Entity
ALTER TABLE `catalog_category_entity`
    DROP FOREIGN KEY CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_category_entity`
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`;
ALTER TABLE `catalog_category_entity`
    MODIFY COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 AUTO_INCREMENT;
ALTER TABLE `catalog_category_entity`
    ADD PRIMARY KEY (`entity_id`);

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `catalog_category_product`
    DROP FOREIGN KEY CAT_CTGR_PRD_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_category_product`
    ADD FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_url_rewrite_product_category`
    DROP FOREIGN KEY CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE `catalog_url_rewrite_product_category`
    ADD FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

DROP TABLE `sequence_catalog_category`;
