-- Restore archived sales documents (Magento_SalesArchive) into the CE grids,
-- otherwise they disappear from the admin grids once the archive tables are dropped.
-- Only the columns shared by both tables are copied (third party modules may add grid columns).

SET SESSION group_concat_max_len = 1000000;

SET @cols = (SELECT GROUP_CONCAT(CONCAT('`', a.COLUMN_NAME, '`')) FROM information_schema.COLUMNS a
    INNER JOIN information_schema.COLUMNS g ON g.TABLE_SCHEMA = a.TABLE_SCHEMA AND g.TABLE_NAME = 'sales_order_grid' AND g.COLUMN_NAME = a.COLUMN_NAME
    WHERE a.TABLE_SCHEMA = DATABASE() AND a.TABLE_NAME = 'magento_sales_order_grid_archive');
SET @sql = IF(@cols IS NULL, 'DO 0', CONCAT('INSERT IGNORE INTO `sales_order_grid` (', @cols, ') SELECT ', @cols, ' FROM `magento_sales_order_grid_archive`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @cols = (SELECT GROUP_CONCAT(CONCAT('`', a.COLUMN_NAME, '`')) FROM information_schema.COLUMNS a
    INNER JOIN information_schema.COLUMNS g ON g.TABLE_SCHEMA = a.TABLE_SCHEMA AND g.TABLE_NAME = 'sales_invoice_grid' AND g.COLUMN_NAME = a.COLUMN_NAME
    WHERE a.TABLE_SCHEMA = DATABASE() AND a.TABLE_NAME = 'magento_sales_invoice_grid_archive');
SET @sql = IF(@cols IS NULL, 'DO 0', CONCAT('INSERT IGNORE INTO `sales_invoice_grid` (', @cols, ') SELECT ', @cols, ' FROM `magento_sales_invoice_grid_archive`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @cols = (SELECT GROUP_CONCAT(CONCAT('`', a.COLUMN_NAME, '`')) FROM information_schema.COLUMNS a
    INNER JOIN information_schema.COLUMNS g ON g.TABLE_SCHEMA = a.TABLE_SCHEMA AND g.TABLE_NAME = 'sales_shipment_grid' AND g.COLUMN_NAME = a.COLUMN_NAME
    WHERE a.TABLE_SCHEMA = DATABASE() AND a.TABLE_NAME = 'magento_sales_shipment_grid_archive');
SET @sql = IF(@cols IS NULL, 'DO 0', CONCAT('INSERT IGNORE INTO `sales_shipment_grid` (', @cols, ') SELECT ', @cols, ' FROM `magento_sales_shipment_grid_archive`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @cols = (SELECT GROUP_CONCAT(CONCAT('`', a.COLUMN_NAME, '`')) FROM information_schema.COLUMNS a
    INNER JOIN information_schema.COLUMNS g ON g.TABLE_SCHEMA = a.TABLE_SCHEMA AND g.TABLE_NAME = 'sales_creditmemo_grid' AND g.COLUMN_NAME = a.COLUMN_NAME
    WHERE a.TABLE_SCHEMA = DATABASE() AND a.TABLE_NAME = 'magento_sales_creditmemo_grid_archive');
SET @sql = IF(@cols IS NULL, 'DO 0', CONCAT('INSERT IGNORE INTO `sales_creditmemo_grid` (', @cols, ') SELECT ', @cols, ' FROM `magento_sales_creditmemo_grid_archive`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Drop EE tables

-- ------------------------------------------------------ --
-- Here we drop the tables without the foreign key check, --
-- because unless your custom development refers to them, --
-- it won't have any interest to keep them in CE          --
-- ------------------------------------------------------ --

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS
    `catalogpermissions_category_cl`,
    `catalogpermissions_product_cl`,
    `event_data`,
    `event_provider`,
    `magento_banner`,
    `magento_banner_catalogrule`,
    `magento_banner_content`,
    `magento_banner_customersegment`,
    `magento_banner_salesrule`,
    `magento_catalogevent_event`,
    `magento_catalogevent_event_image`,
    `magento_catalogpermissions`,
    `magento_catalogpermissions_index`,
    `magento_catalogpermissions_index_product`,
    `magento_catalogpermissions_index_product_replica`,
    `magento_catalogpermissions_index_product_tmp`,
    `magento_catalogpermissions_index_replica`,
    `magento_catalogpermissions_index_tmp`,
    `magento_customerbalance`,
    `magento_customerbalance_history`,
    `magento_customercustomattributes_sales_flat_order`,
    `magento_customercustomattributes_sales_flat_order_address`,
    `magento_customercustomattributes_sales_flat_quote`,
    `magento_customercustomattributes_sales_flat_quote_address`,
    `magento_customersegment_customer`,
    `magento_customersegment_event`,
    `magento_customersegment_segment`,
    `magento_customersegment_website`,
    `magento_giftcard_amount`,
    `magento_giftcardaccount`,
    `magento_giftcardaccount_history`,
    `magento_giftcardaccount_pool`,
    `magento_giftregistry_data`,
    `magento_giftregistry_entity`,
    `magento_giftregistry_item`,
    `magento_giftregistry_item_option`,
    `magento_giftregistry_label`,
    `magento_giftregistry_person`,
    `magento_giftregistry_type`,
    `magento_giftregistry_type_info`,
    `magento_giftwrapping`,
    `magento_giftwrapping_store_attributes`,
    `magento_giftwrapping_website`,
    `magento_invitation`,
    `magento_invitation_status_history`,
    `magento_invitation_track`,
    `magento_logging_event`,
    `magento_logging_event_changes`,
    `magento_reminder_rule`,
    `magento_reminder_rule_coupon`,
    `magento_reminder_rule_log`,
    `magento_reminder_rule_website`,
    `magento_reminder_template`,
    `magento_reward`,
    `magento_reward_history`,
    `magento_reward_rate`,
    `magento_reward_salesrule`,
    `magento_rma`,
    `magento_rma_grid`,
    `magento_rma_item_eav_attribute`,
    `magento_rma_item_eav_attribute_website`,
    `magento_rma_item_entity`,
    `magento_rma_item_entity_datetime`,
    `magento_rma_item_entity_decimal`,
    `magento_rma_item_entity_int`,
    `magento_rma_item_entity_text`,
    `magento_rma_item_entity_varchar`,
    `magento_rma_item_form_attribute`,
    `magento_rma_shipping_label`,
    `magento_rma_status_history`,
    `magento_sales_creditmemo_grid_archive`,
    `magento_sales_invoice_grid_archive`,
    `magento_sales_order_grid_archive`,
    `magento_sales_shipment_grid_archive`,
    `magento_salesrule_filter`,
    `magento_scheduled_operations`,
    `magento_targetrule`,
    `magento_targetrule_customersegment`,
    `magento_targetrule_index`,
    `magento_targetrule_index_crosssell`,
    `magento_targetrule_index_crosssell_product`,
    `magento_targetrule_index_related`,
    `magento_targetrule_index_related_product`,
    `magento_targetrule_index_upsell`,
    `magento_targetrule_index_upsell_product`,
    `magento_targetrule_product`,
    `magento_versionscms_hierarchy_lock`,
    `magento_versionscms_hierarchy_metadata`,
    `magento_versionscms_hierarchy_node`,
    `magento_versionscms_increment`,
    `staging_update`,
    `support_backup`,
    `support_backup_item`,
    `support_report`,
    `quote_preview`,
    `visual_merchandiser_rule`;
SET FOREIGN_KEY_CHECKS = 1;
