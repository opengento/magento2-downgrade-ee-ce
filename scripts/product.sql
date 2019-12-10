-- Enable `entity_id` column for catalog product entity

ALTER TABLE `catalog_product_entity_datetime`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_decimal`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_gallery`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_int`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_text`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_tier_price`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_varchar`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';

-- Enable `parent_id` & `parent_product_id` columns for catalog product bundle

ALTER TABLE `catalog_product_bundle_option`
    ADD COLUMN `new_parent_id` INT(10) UNSIGNED NOT NULL COMMENT 'Parent ID';
ALTER TABLE `catalog_product_bundle_option_value`
    ADD COLUMN `new_parent_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Parent Product ID';
ALTER TABLE `catalog_product_bundle_selection`
    ADD COLUMN `new_parent_product_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Parent Product ID';
ALTER TABLE `catalog_product_bundle_selection_price`
    ADD COLUMN `new_parent_product_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Parent Product ID';

-- Enable `product_id` column for downloadable

ALTER TABLE `downloadable_link`
    ADD COLUMN `new_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Product ID';
ALTER TABLE `downloadable_sample`
    ADD COLUMN `new_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Product ID';

-- Enable `product_id` column for product link

ALTER TABLE `catalog_product_link`
    ADD COLUMN `new_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Product ID';

-- Enable `product_id` column for product option

ALTER TABLE `catalog_product_option`
    ADD COLUMN `new_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Product ID';

-- Enable `child_id` & `parent_id` columns for product relation

ALTER TABLE `catalog_product_relation`
    ADD COLUMN `new_parent_id` INT(10) UNSIGNED NOT NULL COMMENT 'Parent ID';

-- Enable `product_id` column for super attribute

ALTER TABLE `catalog_product_super_attribute`
    ADD COLUMN `new_product_id` INT(10) UNSIGNED NOT NULL COMMENT 'Product ID';

-- Enable `parent_id` column for super link

ALTER TABLE `catalog_product_super_link`
    ADD COLUMN `new_parent_id` INT(10) UNSIGNED NOT NULL COMMENT 'Parent ID';

-- Clean duplicate for catalog product entity

DELETE e
FROM `catalog_product_entity` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `entity_id`
    FROM `catalog_product_entity`
    GROUP BY `entity_id`
) AS p
                         ON e.`entity_id` = p.`entity_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Populate `entity_id` column for catalog product entity

UPDATE `catalog_product_entity_datetime` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_decimal` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_gallery` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_int` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_media_gallery_value` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_media_gallery_value_to_entity` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_text` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_tier_price` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_varchar` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;

-- Populate `parent_id` & `parent_product_id` columns for catalog product bundle

UPDATE `catalog_product_bundle_option` v INNER JOIN `catalog_product_entity` e ON v.`parent_id` = e.`row_id`
SET v.`new_parent_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_bundle_option_value` v INNER JOIN `catalog_product_entity` e ON v.`parent_product_id` = e.`row_id`
SET v.`new_parent_product_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_bundle_selection` v INNER JOIN `catalog_product_entity` e ON v.`parent_product_id` = e.`row_id`
SET v.`new_parent_product_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_bundle_selection_price` v INNER JOIN `catalog_product_entity` e ON v.`parent_product_id` = e.`row_id`
SET v.`new_parent_product_id` = e.`entity_id`
WHERE 1;

-- Populate `product_id` column for downloadable

UPDATE `downloadable_link` v INNER JOIN `catalog_product_entity` e ON v.`product_id` = e.`row_id`
SET v.`new_product_id` = e.`entity_id`
WHERE 1;
UPDATE `downloadable_sample` v INNER JOIN `catalog_product_entity` e ON v.`product_id` = e.`row_id`
SET v.`new_product_id` = e.`entity_id`
WHERE 1;

-- Populate `product_id` column for product link

UPDATE `catalog_product_link` v INNER JOIN `catalog_product_entity` e ON v.`product_id` = e.`row_id`
SET v.`new_product_id` = e.`entity_id`
WHERE 1;

-- Populate `product_id` column for product option

UPDATE `catalog_product_option` v INNER JOIN `catalog_product_entity` e ON v.`product_id` = e.`row_id`
SET v.`new_product_id` = e.`entity_id`
WHERE 1;

-- Populate `parent_id` columns for product relation

UPDATE `catalog_product_relation` v INNER JOIN `catalog_product_entity` e ON v.`parent_id` = e.`row_id`
SET v.`new_parent_id` = e.`entity_id`
WHERE 1;

-- Populate `product_id` column for super attribute

UPDATE `catalog_product_super_attribute` v INNER JOIN `catalog_product_entity` e ON v.`product_id` = e.`row_id`
SET v.`new_product_id` = e.`entity_id`
WHERE 1;

-- Populate `product_id` column for super link

UPDATE `catalog_product_super_link` v INNER JOIN `catalog_product_entity` e ON v.`parent_id` = e.`row_id`
SET v.`new_parent_id` = e.`entity_id`
WHERE 1;

-- -------------
-- Super Link --
-- -------------

ALTER TABLE `catalog_product_super_link`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_SPR_LNK_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_SUPER_LINK_PARENT_ID`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID`,
    DROP COLUMN IF EXISTS `parent_id`,
    RENAME COLUMN `new_parent_id` TO `parent_id`,
    ADD INDEX `CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`product_id`),
    ADD CONSTRAINT `CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` UNIQUE KEY (`product_id`,`parent_id`);

-- ------------------
-- Super Attribute --
-- ------------------

ALTER TABLE `catalog_product_super_attribute`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID`,
    DROP COLUMN IF EXISTS `product_id`,
    RENAME COLUMN `new_product_id` TO `product_id`,
    ADD CONSTRAINT `CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` UNIQUE KEY (`product_id`,`attribute_id`);

-- -------------------
-- Product Relation --
-- -------------------

ALTER TABLE `catalog_product_relation`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID`,
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_RELATION_CHILD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    DROP PRIMARY KEY,
    DROP COLUMN IF EXISTS `parent_id`,
    RENAME COLUMN `new_parent_id` TO `parent_id`,
    ADD INDEX `CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
    ADD PRIMARY KEY (`parent_id`,`child_id`);

-- -----------------
-- Product Option --
-- -----------------

ALTER TABLE `catalog_product_option`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_OPTION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_OPTION_PRODUCT_ID`,
    DROP COLUMN IF EXISTS `product_id`,
    RENAME COLUMN `new_product_id` TO `product_id`,
    ADD INDEX `CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`);

-- ---------------
-- Product Link --
-- ---------------

ALTER TABLE `catalog_product_link`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_LNK_LNKED_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_LINK_PRODUCT_ID`,
    DROP COLUMN IF EXISTS `product_id`,
    RENAME COLUMN `new_product_id` TO `product_id`,
    ADD INDEX CATALOG_PRODUCT_LINK_PRODUCT_ID (`product_id`);

-- ---------------
-- Downloadable --
-- ---------------

ALTER TABLE `downloadable_link`
    DROP FOREIGN KEY IF EXISTS `DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
    DROP INDEX IF EXISTS `DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER`,
    DROP COLUMN IF EXISTS `product_id`,
    RENAME COLUMN `new_product_id` TO `product_id`,
    ADD INDEX `DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`);

ALTER TABLE `downloadable_sample`
    DROP FOREIGN KEY IF EXISTS `DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
    DROP COLUMN IF EXISTS `product_id`,
    RENAME COLUMN `new_product_id` TO `product_id`;

-- -----------------
-- Product Bundle --
-- -----------------

ALTER TABLE `catalog_product_bundle_option`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_OPT_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP INDEX IF EXISTS `CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID`,
    DROP PRIMARY KEY,
    DROP COLUMN IF EXISTS `parent_id`,
    RENAME COLUMN `new_parent_id` TO `parent_id`,
    ADD CONSTRAINT `CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` UNIQUE KEY (`parent_id`),
    ADD PRIMARY KEY (`option_id`);

ALTER TABLE `catalog_product_bundle_option_value`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_OPT_VAL_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_OPT_VAL_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP INDEX IF EXISTS `CAT_PRD_BNDL_OPT_VAL_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP INDEX IF EXISTS `CAT_PRD_BNDL_OPT_VAL_OPT_ID_PARENT_PRD_ID_STORE_ID`,
    DROP COLUMN IF EXISTS `parent_id`,
    RENAME COLUMN `new_parent_product_id` TO `parent_product_id`,
    ADD CONSTRAINT `CAT_PRD_BNDL_OPT_VAL_OPT_ID_PARENT_PRD_ID_STORE_ID` UNIQUE KEY (`option_id`,`parent_product_id`,`store_id`),
    ADD CONSTRAINT `CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_product_bundle_selection`
    DROP CONSTRAINT IF EXISTS `CAT_PRD_BNDL_SELECTION_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
    DROP CONSTRAINT IF EXISTS `CAT_PRD_BNDL_SELECTION_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP CONSTRAINT IF EXISTS `CAT_PRD_BNDL_SELECTION_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    DROP CONSTRAINT IF EXISTS `FK_606117FEB5F50D0182CEC9D260C05DD2`,
    DROP PRIMARY KEY,
    DROP COLUMN IF EXISTS `parent_product_id`,
    RENAME COLUMN `new_parent_product_id` TO `parent_product_id`,
    ADD CONSTRAINT `CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD PRIMARY KEY (`selection_id`);

ALTER TABLE `catalog_product_bundle_selection_price`
    DROP CONSTRAINT IF EXISTS `CAT_PRD_BNDL_SELECTION_PRICE_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
    DROP CONSTRAINT IF EXISTS `CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_STORE_WS_WS_ID`,
    DROP CONSTRAINT IF EXISTS `FK_AE9FDBF7988FB6BE3E04D91DA2CFB273`,
    DROP PRIMARY KEY,
    DROP COLUMN IF EXISTS `parent_product_id`,
    RENAME COLUMN `new_parent_product_id` TO `parent_product_id`,
    ADD CONSTRAINT `CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `store_website` (`website_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD PRIMARY KEY (`selection_id`,`parent_product_id`,`website_id`);

-- ------------------------------------------------------------------
-- Update the `entity_id` relation link for catalog product entity --
-- ------------------------------------------------------------------

-- Datetime
ALTER TABLE `catalog_product_entity_datetime`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_DTIME_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_datetime`;
ALTER TABLE `catalog_product_entity_datetime`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Decimal
ALTER TABLE `catalog_product_entity_decimal`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_DEC_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_decimal`;
ALTER TABLE `catalog_product_entity_decimal`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Int
ALTER TABLE `catalog_product_entity_int`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_ENTITY_INT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_int`;
ALTER TABLE `catalog_product_entity_int`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Text
ALTER TABLE `catalog_product_entity_text`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_ENTITY_TEXT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_text`;
ALTER TABLE `catalog_product_entity_text`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Varchar
ALTER TABLE `catalog_product_entity_varchar`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_VCHR_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_varchar`;
ALTER TABLE `catalog_product_entity_varchar`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery
ALTER TABLE `catalog_product_entity_gallery`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_GLR_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_gallery`;
ALTER TABLE `catalog_product_entity_gallery`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`,`attribute_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery value
ALTER TABLE `catalog_product_entity_media_gallery_value`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_VAL_ID_STORE_ID` ON `catalog_product_entity_media_gallery_value`;
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_VAL_ID_STORE_ID` UNIQUE KEY (`entity_id`,`value_id`,`store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery value to entity
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` ON `catalog_product_entity_media_gallery_value_to_entity`;
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` UNIQUE KEY (`value_id`,`entity_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Tier price
ALTER TABLE `catalog_product_entity_tier_price`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_ENTT_TIER_PRICE_ROW_ID_CAT_PRD_ENTT_ROW_ID`;
DROP INDEX IF EXISTS `UNQ_E8AB433B9ACB00343ABB312AD2FAB087` ON `catalog_product_entity_tier_price`;
ALTER TABLE `catalog_product_entity_tier_price`
    ADD CONSTRAINT `UNQ_E8AB433B9ACB00343ABB312AD2FAB087` UNIQUE KEY (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Entity
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_ENTITY_ID_CREATED_IN_UPDATED_IN` ON `catalog_product_entity`;
ALTER TABLE `catalog_product_entity`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_ENTITY_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`,
    DROP COLUMN IF EXISTS `row_id`,
    DROP COLUMN IF EXISTS `created_in`,
    DROP COLUMN IF EXISTS `updated_in`,
    MODIFY COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT 'Entity ID',
    ADD PRIMARY KEY (`entity_id`);

-- Foreign keys
ALTER TABLE `catalog_product_entity_datetime`
    ADD CONSTRAINT `CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_decimal`
    ADD CONSTRAINT `CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_int`
    ADD CONSTRAINT `CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_text`
    ADD CONSTRAINT `CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_varchar`
    ADD CONSTRAINT `CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_gallery`
    ADD CONSTRAINT `CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_tier_price`
    ADD CONSTRAINT `CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_bundle_option`
    ADD CONSTRAINT `CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_bundle_selection`
    ADD CONSTRAINT `CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `downloadable_link`
    ADD CONSTRAINT `DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `downloadable_sample`
    ADD CONSTRAINT `DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_link`
    ADD CONSTRAINT `CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD CONSTRAINT `CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_option`
    ADD CONSTRAINT `CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_relation`
    ADD CONSTRAINT `CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD CONSTRAINT `CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_super_attribute`
    ADD CONSTRAINT `CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_super_link`
    ADD CONSTRAINT `CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
    ADD CONSTRAINT `CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `catalog_category_product`
    DROP FOREIGN KEY IF EXISTS `CAT_CTGR_PRD_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    ADD CONSTRAINT `CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_compare_item`
    DROP FOREIGN KEY IF EXISTS `CATALOG_COMPARE_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`,
    ADD CONSTRAINT `CATALOG_COMPARE_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_product_bundle_price_index`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    ADD CONSTRAINT `CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- catalog_product_index_tier_price
-- catalog_product_website
-- catalog_url_rewrite_product_category
-- cataloginventory_stock_item
-- product_alert_price
-- product_alert_stock
-- report_compared_product_index
-- report_viewed_product_aggregated_daily
-- report_viewed_product_aggregated_monthly
-- report_viewed_product_aggregated_yearly
-- report_viewed_product_index
-- weee_tax
-- wishlist_item


DROP TABLE `sequence_product_bundle_option`,`sequence_product_bundle_selection`,`sequence_product`;
