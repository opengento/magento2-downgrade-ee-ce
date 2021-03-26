SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS
    `magento_acknowledged_bulk`,
    `magento_banner`,
    `magento_banner_catalogrule`,
    `magento_banner_content`,
    `magento_banner_customersegment`,
    `magento_banner_salesrule`,
    `magento_bulk`,
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
    `magento_operation`,
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
    `visual_merchandiser_rule`;

-- CMS
delete from cms_block where row_id in (12,289)

ALTER TABLE `cms_block_store`
CHANGE `row_id` `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
DROP PRIMARY KEY,
ADD PRIMARY KEY (`block_id`,`store_id`),
DROP FOREIGN KEY `CMS_BLOCK_STORE_ROW_ID_CMS_BLOCK_ROW_ID`,
ADD CONSTRAINT `CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE;

UPDATE cms_block SET block_id = row_id;
ALTER TABLE cms_block DROP FOREIGN KEY CMS_BLOCK_BLOCK_ID_SEQUENCE_CMS_BLOCK_SEQUENCE_VALUE;
ALTER TABLE cms_block MODIFY COLUMN row_id smallint COMMENT 'Version Id';
ALTER TABLE cms_block MODIFY COLUMN block_id smallint auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE cms_block DROP PRIMARY KEY;
ALTER TABLE cms_block ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (block_id);
ALTER TABLE cms_block DROP COLUMN row_id;

ALTER TABLE `cms_page_store`
CHANGE `row_id` `page_id`  smallint(6) NOT NULL COMMENT 'Page ID',
DROP PRIMARY KEY,
ADD PRIMARY KEY (`page_id`,`store_id`),
DROP FOREIGN KEY `CMS_PAGE_STORE_ROW_ID_CMS_PAGE_ROW_ID`,
ADD CONSTRAINT `CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE;

UPDATE cms_page set page_id = row_id ;
ALTER TABLE cms_page DROP FOREIGN KEY CMS_PAGE_PAGE_ID_SEQUENCE_CMS_PAGE_SEQUENCE_VALUE;
ALTER TABLE cms_page MODIFY COLUMN row_id smallint NOT NULL COMMENT 'Version Id';
ALTER TABLE cms_page MODIFY COLUMN page_id smallint auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE cms_page DROP PRIMARY KEY;
ALTER TABLE cms_page ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (page_id);
ALTER TABLE cms_page DROP COLUMN row_id;

-- PRODUCT

ALTER TABLE `catalog_product_entity_datetime`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_DTIME_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_decimal`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_DEC_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_int`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CATALOG_PRODUCT_ENTITY_INT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_text`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CATALOG_PRODUCT_ENTITY_TEXT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_varchar`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_VCHR_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_bundle_option`
DROP FOREIGN KEY `CAT_PRD_BNDL_OPT_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
DROP FOREIGN KEY `CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_bundle_option_value`
DROP KEY `CAT_PRD_BNDL_OPT_VAL_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
DROP FOREIGN KEY `CAT_PRD_BNDL_OPT_VAL_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
DROP FOREIGN KEY `CAT_PRD_BNDL_OPT_VAL_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_bundle_selection`
DROP KEY `CAT_PRD_BNDL_SELECTION_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
DROP FOREIGN KEY `CAT_PRD_BNDL_SELECTION_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL`,
DROP FOREIGN KEY `CAT_PRD_BNDL_SELECTION_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
DROP FOREIGN KEY `CAT_PRD_BNDL_SELECTION_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
DROP FOREIGN KEY `FK_606117FEB5F50D0182CEC9D260C05DD2`,
ADD CONSTRAINT `CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE,
ADD CONSTRAINT `CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_bundle_selection_price`
DROP KEY `CAT_PRD_BNDL_SELECTION_PRICE_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
DROP FOREIGN KEY `FK_AE9FDBF7988FB6BE3E04D91DA2CFB273`,
DROP FOREIGN KEY `CAT_PRD_BNDL_SELECTION_PRICE_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_gallery`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_GLR_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;
ALTER TABLE catalog_product_entity_gallery RENAME INDEX CATALOG_PRODUCT_ENTITY_GALLERY_ROW_ID TO CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID;
ALTER TABLE catalog_product_entity_gallery RENAME INDEX CATALOG_PRODUCT_ENTITY_GALLERY_ROW_ID_ATTRIBUTE_ID_STORE_ID TO CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID;


ALTER TABLE `catalog_product_entity_media_gallery_value`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_MDA_GLR_VAL_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP KEY `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD KEY `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` (`entity_id`),
DROP FOREIGN KEY `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_entity_tier_price`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP FOREIGN KEY `CAT_PRD_ENTT_TIER_PRICE_ROW_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_link`
DROP FOREIGN KEY `CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
DROP FOREIGN KEY `CAT_PRD_LNK_LNKED_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
ADD CONSTRAINT `CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;


ALTER TABLE `catalog_product_option`
DROP FOREIGN KEY `CATALOG_PRODUCT_OPTION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_relation`
DROP FOREIGN KEY `CATALOG_PRODUCT_RELATION_PARENT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `CATALOG_PRODUCT_RELATION_PARENT_ID_CATALOG_PRODUCT_ENTITY_ENT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
DROP FOREIGN KEY `CAT_PRD_RELATION_CHILD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
ADD CONSTRAINT `CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_product_super_attribute`
DROP FOREIGN KEY `CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;


ALTER TABLE `catalog_product_super_link`
DROP FOREIGN KEY `CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ROW_ID`,
DROP FOREIGN KEY `CAT_PRD_SPR_LNK_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
ADD CONSTRAINT `CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE,
ADD CONSTRAINT `CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `downloadable_link`
DROP FOREIGN KEY `DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `downloadable_sample`
DROP FOREIGN KEY `DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID`,
ADD CONSTRAINT `DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;


UPDATE catalog_product_website cpw
inner join catalog_product_entity cpe on cpe.entity_id = cpw.product_id
set cpw.product_id  = cpe.row_id ;

UPDATE catalog_category_product ccp
inner join catalog_product_entity cpe on cpe.entity_id = ccp.product_id
set ccp.product_id  = cpe.row_id ;

UPDATE catalog_product_link cpl
inner join catalog_product_entity cpe on cpe.entity_id = cpl.linked_product_id 
set cpl.linked_product_id = cpe.row_id ;

UPDATE catalog_product_relation cpr
inner join catalog_product_entity cpe on cpe.entity_id = cpr.child_id 
set cpr.child_id = cpe.row_id ;


UPDATE catalog_product_entity set entity_id = row_id ;
ALTER TABLE catalog_product_entity DROP FOREIGN KEY CATALOG_PRODUCT_ENTITY_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE;
ALTER TABLE catalog_product_entity MODIFY COLUMN row_id int unsigned NOT NULL COMMENT 'Version Id';
ALTER TABLE catalog_product_entity MODIFY COLUMN entity_id int unsigned auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE catalog_product_entity DROP PRIMARY KEY;
ALTER TABLE catalog_product_entity ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (entity_id);
ALTER TABLE catalog_product_entity DROP COLUMN row_id;

DROP TABLE IF EXISTS `sequence_product_bundle_selection`,`sequence_product_bundle_option`,`sequence_product`;

-- CATEGORY

ALTER TABLE `catalog_category_entity_datetime`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP INDEX `CATALOG_CATEGORY_ENTITY_DATETIME_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
ADD UNIQUE KEY `CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
DROP FOREIGN KEY `CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_category_entity_decimal`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP INDEX `CATALOG_CATEGORY_ENTITY_DECIMAL_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
ADD UNIQUE KEY `CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
DROP FOREIGN KEY `CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_category_entity_int`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP INDEX `CATALOG_CATEGORY_ENTITY_INT_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
ADD UNIQUE KEY `CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
DROP FOREIGN KEY `CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_category_entity_text`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP INDEX `CATALOG_CATEGORY_ENTITY_TEXT_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
ADD UNIQUE KEY `CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
DROP FOREIGN KEY `CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE;

ALTER TABLE `catalog_category_entity_varchar`
CHANGE `row_id` `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
DROP INDEX `CATALOG_CATEGORY_ENTITY_VARCHAR_ROW_ID_ATTRIBUTE_ID_STORE_ID`,
ADD UNIQUE KEY `CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
DROP FOREIGN KEY `CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID`,
ADD CONSTRAINT `CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE;

UPDATE catalog_category_entity set entity_id = row_id ;
ALTER TABLE catalog_category_entity DROP FOREIGN KEY CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL;
ALTER TABLE catalog_category_entity MODIFY COLUMN row_id int unsigned NOT NULL COMMENT 'Version Id';
ALTER TABLE catalog_category_entity MODIFY COLUMN entity_id int unsigned auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE catalog_category_entity DROP PRIMARY KEY;
ALTER TABLE catalog_category_entity ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (entity_id);
ALTER TABLE catalog_category_entity DROP COLUMN row_id;

-- SALES RULE

ALTER TABLE `salesrule_customer_group`
CHANGE `row_id` `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
DROP FOREIGN KEY `SALESRULE_CUSTOMER_GROUP_ROW_ID_SALESRULE_ROW_ID`,
ADD CONSTRAINT `SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;

ALTER TABLE `salesrule_product_attribute`
CHANGE `row_id` `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
DROP FOREIGN KEY `SALESRULE_PRODUCT_ATTRIBUTE_ROW_ID_SALESRULE_ROW_ID`,
ADD CONSTRAINT `SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;

ALTER TABLE `salesrule_website`
CHANGE `row_id` `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
DROP FOREIGN KEY `SALESRULE_WEBSITE_ROW_ID_SALESRULE_ROW_ID`,
ADD CONSTRAINT `SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;

ALTER TABLE `salesrule_coupon`
DROP FOREIGN KEY `SALESRULE_COUPON_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE`;

-- 		Sales Rule amasty
		ALTER TABLE `amasty_ampromo_rule`
		DROP FOREIGN KEY `AMASTY_AMPROMO_RULE_SALESRULE_ID_SALESRULE_ROW_ID`,
		ADD CONSTRAINT `AMASTY_AMPROMO_RULE_SALESRULE_ID_SALESRULE_ENTT_ID` FOREIGN KEY (`salesrule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;
		
		ALTER TABLE `amasty_banners_lite_banner_data` DROP FOREIGN KEY `AMASTY_BANNERS_LITE_BANNER_DATA_SALESRULE_ID_SALESRULE_RULE_ID`;
		ALTER TABLE `amasty_banners_lite_banner_data` ADD CONSTRAINT `AMASTY_BANNERS_LITE_BANNER_DATA_SALESRULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`salesrule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;
		
		ALTER TABLE `amasty_banners_lite_rule` DROP FOREIGN KEY `AMASTY_BANNERS_LITE_RULE_SALESRULE_ID_SALESRULE_RULE_ID`;
		ALTER TABLE `amasty_banners_lite_rule` ADD CONSTRAINT `AMASTY_BANNERS_LITE_RULE_SALESRULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`salesrule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE;

UPDATE salesrule SET rule_id = row_id;
ALTER TABLE salesrule DROP FOREIGN KEY SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE;
ALTER TABLE salesrule MODIFY COLUMN row_id int unsigned NOT NULL COMMENT 'Version Id';
ALTER TABLE salesrule MODIFY COLUMN rule_id int unsigned auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE salesrule DROP PRIMARY KEY;
ALTER TABLE salesrule ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (rule_id);
ALTER TABLE salesrule DROP COLUMN row_id;


-- CATALOG RULE

ALTER TABLE `catalogrule_customer_group`
CHANGE `row_id` `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
DROP FOREIGN KEY `CATALOGRULE_CUSTOMER_GROUP_ROW_ID_CATALOGRULE_ROW_ID`,
ADD CONSTRAINT `CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE;

ALTER TABLE `catalogrule_website`
CHANGE `row_id` `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
DROP FOREIGN KEY `CATALOGRULE_WEBSITE_ROW_ID_CATALOGRULE_ROW_ID`,
ADD CONSTRAINT `CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE;

UPDATE catalogrule SET rule_id = row_id;
ALTER TABLE catalogrule DROP FOREIGN KEY CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE;
ALTER TABLE catalogrule MODIFY COLUMN row_id int unsigned NOT NULL COMMENT 'Version Id';
ALTER TABLE catalogrule MODIFY COLUMN rule_id int unsigned auto_increment NOT NULL COMMENT 'Entity Id';
ALTER TABLE catalogrule DROP PRIMARY KEY;
ALTER TABLE catalogrule ADD CONSTRAINT `PRIMARY_KEY` PRIMARY KEY (rule_id);
ALTER TABLE catalogrule DROP COLUMN row_id;


ALTER TABLE catalog_category_product DROP FOREIGN KEY `CAT_CTGR_PRD_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE catalog_category_product DROP FOREIGN KEY `CAT_CTGR_PRD_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL`;
ALTER TABLE catalog_compare_item DROP FOREIGN KEY `CATALOG_COMPARE_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
ALTER TABLE catalog_product_index_tier_price DROP FOREIGN KEY `CAT_PRD_IDX_TIER_PRICE_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE catalog_product_website DROP FOREIGN KEY `CAT_PRD_WS_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE catalog_url_rewrite_product_category DROP FOREIGN KEY `CAT_URL_REWRITE_PRD_CTGR_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE cataloginventory_stock_item DROP FOREIGN KEY `CATINV_STOCK_ITEM_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE email_catalog DROP FOREIGN KEY `EMAIL_CATALOG_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
ALTER TABLE product_alert_price DROP FOREIGN KEY `PRODUCT_ALERT_PRICE_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
ALTER TABLE catalog_product_bundle_price_index DROP FOREIGN KEY `CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE product_alert_stock DROP FOREIGN KEY `PRODUCT_ALERT_STOCK_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
ALTER TABLE report_compared_product_index DROP FOREIGN KEY `REPORT_CMPD_PRD_IDX_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE report_viewed_product_aggregated_daily DROP FOREIGN KEY `REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE report_viewed_product_aggregated_monthly DROP FOREIGN KEY `FK_0140003A30AFC1A9188D723C4634BA5D`;
ALTER TABLE report_viewed_product_aggregated_yearly DROP FOREIGN KEY `REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE report_viewed_product_index DROP FOREIGN KEY `REPORT_VIEWED_PRD_IDX_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`;
ALTER TABLE weee_tax DROP FOREIGN KEY `WEEE_TAX_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
ALTER TABLE wishlist_item DROP FOREIGN KEY `WISHLIST_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;

DELETE
FROM `eav_entity_type`
WHERE `entity_type_code` IN ('rma_item','cms_page','cms_block');

DELETE
FROM `eav_attribute`
WHERE `attribute_code` IN (
                           'reward_update_notification',
                           'reward_warning_notification',
                           'automatic_sorting',
                           'allow_message',
                           'allow_open_amount',
                           'email_template',
                           'giftcard_amounts',
                           'giftcard_type',
                           'gift_wrapping_available',
                           'gift_wrapping_price',
                           'is_redeemable',
                           'is_returnable',
                           'lifetime',
                           'open_amount_max',
                           'open_amount_min',
                           'related_tgtr_position_behavior',
                           'related_tgtr_position_limit',
                           'upsell_tgtr_position_behavior',
                           'upsell_tgtr_position_limit',
                           'use_config_allow_message',
                           'use_config_email_template',
                           'use_config_is_redeemable',
                           'use_config_lifetime',
                           'reward_points_balance_refunded',
                           'reward_salesrule_points',
                           'condition',
                           'is_qty_decimal',
                           'order_item_id',
                           'product_admin_name',
                           'product_admin_sku',
                           'product_name',
                           'product_options',
                           'product_sku',
                           'qty_approved',
                           'qty_authorized',
                           'qty_requested',
                           'qty_returned',
                           'reason',
                           'reason_other',
                           'resolution',
                           'rma_entity_id'
                           
    );
   
-- alter table `wishlist` rename index WISHLIST_CUSTOMER_ID to WISHLIST_CUSTOMER_ID_DELETE_ME;

 ALTER TABLE wishlist DROP INDEX WISHLIST_CUSTOMER_ID;




-- ALTER TABLE `wishlist` ADD CONSTRAINT `WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE;


DELETE  from wishlist where wishlist_id = 1710;
DELETE  from wishlist where wishlist_id = 4385;

-- delete from core_config_data where config_id in (726,727,2847,2848,2862,2863)
DELETE FROM `eav_attribute` WHERE `attribute_code` IN (
   'sale_id',
   'cogs_id',
   'tracking_category');
  
  
SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_NAME = 'wishlist' ;
 
 
