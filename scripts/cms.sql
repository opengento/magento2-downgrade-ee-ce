-- Enable `block_id` for block store
ALTER TABLE `cms_block_store`
    ADD COLUMN `block_id` SMALLINT(6) NOT NULL COMMENT 'Entity ID';

-- Enable `page_id` for page store
ALTER TABLE `cms_page_store`
    ADD COLUMN `page_id` SMALLINT(6) NOT NULL COMMENT 'Entity ID';

-- Clean duplicates for cms block
DELETE e
FROM `cms_block` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `block_id`
    FROM `cms_block`
    GROUP BY `block_id`
) AS p
                         ON e.`block_id` = p.`block_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Clean duplicates for cms page
DELETE e
FROM `cms_page` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `page_id`
    FROM `cms_page`
    GROUP BY `page_id`
) AS p
                         ON e.`page_id` = p.`page_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Populate `block_id` column for block store
UPDATE `cms_block_store` v INNER JOIN `cms_block` e ON v.`row_id` = e.`row_id`
SET v.`block_id` = e.`block_id`
WHERE 1;

-- Populate `page_id` column for page store
UPDATE `cms_page_store` v INNER JOIN `cms_page` e ON v.`row_id` = e.`row_id`
SET v.`page_id` = e.`page_id`
WHERE 1;

-- Update the `block_id` relation link for block store
ALTER TABLE `cms_block_store`
    DROP FOREIGN KEY `CMS_BLOCK_STORE_ROW_ID_CMS_BLOCK_ROW_ID`,
    DROP PRIMARY KEY,
    DROP COLUMN `row_id`,
    ADD PRIMARY KEY (`block_id`,`store_id`);

SET FOREIGN_KEY_CHECKS = 0; # Many third party modules refers to the `block_id` column, we prevent blocking.
ALTER TABLE `cms_block`
    DROP FOREIGN KEY `CMS_BLOCK_BLOCK_ID_SEQUENCE_CMS_BLOCK_SEQUENCE_VALUE`,
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`,
    ADD PRIMARY KEY (`block_id`),
    MODIFY COLUMN `block_id` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Entity ID';
SET FOREIGN_KEY_CHECKS = 1;

-- Update the `page_id` relation link for page store
ALTER TABLE `cms_page_store`
    DROP FOREIGN KEY `CMS_PAGE_STORE_ROW_ID_CMS_PAGE_ROW_ID`,
    DROP PRIMARY KEY,
    DROP COLUMN `row_id`,
    ADD PRIMARY KEY (`page_id`,`store_id`);

SET FOREIGN_KEY_CHECKS = 0; # Many third party modules refers to the `page_id` column, we prevent blocking.
ALTER TABLE `cms_page`
    DROP FOREIGN KEY `CMS_PAGE_PAGE_ID_SEQUENCE_CMS_PAGE_SEQUENCE_VALUE`,
    DROP COLUMN `row_id`,
    DROP COLUMN `created_in`,
    DROP COLUMN `updated_in`,
    ADD PRIMARY KEY (`page_id`),
    MODIFY COLUMN `page_id` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Entity ID';
SET FOREIGN_KEY_CHECKS = 1;

-- Foreign keys cms block
ALTER TABLE `cms_block_store`
    ADD CONSTRAINT `CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- Foreign keys cms page
ALTER TABLE `cms_page_store`
    ADD CONSTRAINT `CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

DROP TABLE `sequence_cms_page`,`sequence_cms_block`;
