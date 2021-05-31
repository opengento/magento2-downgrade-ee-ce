-- Drop EE tables

-- ------------------------------------------------------ --
-- Here we drop the tables without the foreign key check, --
-- because unless your custom development refers to them, --
-- it won't have any interest to keep them in CE          --
-- 1113 table
-- ------------------------------------------------------ --

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS
    `cms_block_customersegment`,
    `cms_page_customersegment`,
    `temando_rma_shipment`;
SET FOREIGN_KEY_CHECKS = 1;

