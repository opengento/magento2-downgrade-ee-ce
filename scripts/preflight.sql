-- Read-only checks, run them BEFORE the migration scripts.
-- Every query is expected to return no row; otherwise read the comment above it.

-- 1. Triggers would still reference `row_id` once dropped: switch all indexers to "Update on Save" first.
SELECT `TRIGGER_NAME`, `EVENT_OBJECT_TABLE`
FROM information_schema.TRIGGERS
WHERE `TRIGGER_SCHEMA` = DATABASE();

-- 2. Foreign keys on staging columns that the scripts do not handle (third party modules, or a constraint
--    name that differs on this install). The scripts will fail on them: drop them or adapt the scripts.
SELECT `TABLE_NAME`, `CONSTRAINT_NAME`, `REFERENCED_TABLE_NAME`, `REFERENCED_COLUMN_NAME`
FROM information_schema.KEY_COLUMN_USAGE
WHERE `TABLE_SCHEMA` = DATABASE()
  AND (`REFERENCED_TABLE_NAME` LIKE 'sequence\_%' OR `REFERENCED_COLUMN_NAME` = 'row_id')
  AND `TABLE_NAME` NOT LIKE 'magento\_%'
  AND `TABLE_NAME` NOT IN ('catalogpermissions_category_cl', 'catalogpermissions_product_cl', 'quote_preview', 'visual_merchandiser_rule', 'staging_update')
  AND `CONSTRAINT_NAME` NOT IN (
        'CATALOG_COMPARE_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE',
        'CATALOG_PRODUCT_ENTITY_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE',
        'CATALOG_PRODUCT_ENTITY_INT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'CATALOG_PRODUCT_ENTITY_TEXT_ROW_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'CATALOG_PRODUCT_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'CATALOG_PRODUCT_OPTION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'CATALOG_PRODUCT_RELATION_PARENT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'CATALOGRULE_CUSTOMER_GROUP_ROW_ID_CATALOGRULE_ROW_ID',
        'CATALOGRULE_RULE_ID_SEQUENCE_CATALOGRULE_SEQUENCE_VALUE',
        'CATALOGRULE_WEBSITE_ROW_ID_CATALOGRULE_ROW_ID',
        'CAT_CTGR_ENTT_DEC_ROW_ID_CAT_CTGR_ENTT_ROW_ID',
        'CAT_CTGR_ENTT_DTIME_ROW_ID_CAT_CTGR_ENTT_ROW_ID',
        'CAT_CTGR_ENTT_ENTT_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL',
        'CAT_CTGR_ENTT_INT_ROW_ID_CAT_CTGR_ENTT_ROW_ID',
        'CAT_CTGR_ENTT_TEXT_ROW_ID_CAT_CTGR_ENTT_ROW_ID',
        'CAT_CTGR_ENTT_VCHR_ROW_ID_CAT_CTGR_ENTT_ROW_ID',
        'CAT_CTGR_PRD_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL',
        'CAT_CTGR_PRD_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CATINV_STOCK_ITEM_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_BNDL_OPT_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL',
        'CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_BNDL_OPT_VAL_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL',
        'CAT_PRD_BNDL_OPT_VAL_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_BNDL_SELECTION_OPT_ID_SEQUENCE_PRD_BNDL_OPT_SEQUENCE_VAL',
        'CAT_PRD_BNDL_SELECTION_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_BNDL_SELECTION_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_BNDL_SELECTION_PRICE_PARENT_PRD_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_DEC_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_DTIME_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_GLR_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_MDA_GLR_VAL_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_TIER_PRICE_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_ENTT_VCHR_ROW_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_IDX_TIER_PRICE_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_LNK_LNKED_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_RELATION_CHILD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ROW_ID',
        'CAT_PRD_SPR_LNK_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_PRD_WS_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CAT_URL_REWRITE_PRD_CTGR_CTGR_ID_SEQUENCE_CAT_CTGR_SEQUENCE_VAL',
        'CAT_URL_REWRITE_PRD_CTGR_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'CMS_BLOCK_BLOCK_ID_SEQUENCE_CMS_BLOCK_SEQUENCE_VALUE',
        'CMS_BLOCK_STORE_ROW_ID_CMS_BLOCK_ROW_ID',
        'CMS_PAGE_PAGE_ID_SEQUENCE_CMS_PAGE_SEQUENCE_VALUE',
        'CMS_PAGE_STORE_ROW_ID_CMS_PAGE_ROW_ID',
        'DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'DOWNLOADABLE_SAMPLE_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ROW_ID',
        'FK_0140003A30AFC1A9188D723C4634BA5D',
        'FK_606117FEB5F50D0182CEC9D260C05DD2',
        'FK_AE9FDBF7988FB6BE3E04D91DA2CFB273',
        'PRODUCT_ALERT_PRICE_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE',
        'PRODUCT_ALERT_STOCK_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE',
        'REPORT_CMPD_PRD_IDX_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'REPORT_VIEWED_PRD_IDX_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL',
        'SALESRULE_COUPON_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE',
        'SALESRULE_CUSTOMER_GROUP_ROW_ID_SALESRULE_ROW_ID',
        'SALESRULE_CUSTOMER_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE',
        'SALESRULE_LABEL_ROW_ID_SALESRULE_ROW_ID',
        'SALESRULE_PRODUCT_ATTRIBUTE_ROW_ID_SALESRULE_ROW_ID',
        'SALESRULE_RULE_ID_SEQUENCE_SALESRULE_SEQUENCE_VALUE',
        'SALESRULE_WEBSITE_ROW_ID_SALESRULE_ROW_ID',
        'WEEE_TAX_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE',
        'WISHLIST_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE'
    );

-- 3. Staging updates active now or scheduled: only the version active now is kept,
--    a running campaign becomes permanent and future campaigns are lost.
SELECT `id`, `name`, `start_time`, `end_time`
FROM `staging_update`
WHERE `start_time` > NOW() OR `end_time` > NOW();

-- 4. Gift card products: this product type does not exist in CE, delete or convert them.
SELECT `entity_id`, `sku`
FROM `catalog_product_entity`
WHERE `type_id` = 'giftcard';

-- 5. EAV attributes using EE classes: "class does not exist" errors in CE.
SELECT a.`attribute_id`, a.`attribute_code`, a.`backend_model`, a.`source_model`, a.`frontend_model`
FROM `eav_attribute` a
WHERE CONCAT_WS(' ', a.`backend_model`, a.`source_model`, a.`frontend_model`)
          REGEXP 'Magento.(AdminGws|AdvancedCheckout|Banner|CatalogEvent|CatalogPermissions|CatalogStaging|CustomerBalance|CustomerCustomAttributes|CustomerSegment|GiftCard|GiftRegistry|GiftWrapping|Invitation|Logging|MultipleWishlist|Reminder|Reward|Rma|SalesArchive|Staging|TargetRule|VersionsCms|VisualMerchandiser)';

-- 6. Widgets and CMS content using EE blocks (banners / dynamic blocks, catalog events, gift registry, CMS hierarchy).
SELECT 'widget_instance' AS `source`, `instance_id` AS `id`, `instance_type` AS `detail`
FROM `widget_instance`
WHERE `instance_type` REGEXP 'Magento.(Banner|CatalogEvent|GiftRegistry|VersionsCms|TargetRule|CustomerSegment|Reward|Rma)'
UNION ALL
SELECT 'cms_page', `page_id`, `identifier`
FROM `cms_page`
WHERE `content` REGEXP 'Magento.{1,2}(Banner|CatalogEvent|GiftRegistry|VersionsCms)|dynamic_block'
UNION ALL
SELECT 'cms_block', `block_id`, `identifier`
FROM `cms_block`
WHERE `content` REGEXP 'Magento.{1,2}(Banner|CatalogEvent|GiftRegistry|VersionsCms)|dynamic_block';
