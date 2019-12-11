-- Drop EE tables

DROP TABLE IF EXISTS
    `magento_catalogpermissions`,
    `magento_targetrule_product`,
    `visual_merchandiser_rule`;

# Cannot delete or update a parent row: a foreign key constraint fails
# remove all magento_* tables

# Removed by scripts:

# `magento_versionscms_hierarchy_lock`,
# `magento_versionscms_hierarchy_metadata`,
# `magento_versionscms_hierarchy_node`,
# `magento_versionscms_increment`,
# `magento_banner_salesrule`,
# `magento_reward_salesrule`,
# `magento_salesrule_filter`,
# `magento_banner_catalogrule`,
# `magento_catalogevent_event_image`,
# `magento_catalogevent_event`,
# `magento_reminder_rule_coupon`,
# `magento_reminder_rule_website`,
# `magento_reminder_template`,
# `magento_reminder_rule_log`,
# `magento_reminder_rule`
# `magento_giftregistry_item_option`,
# `magento_giftregistry_item`,
# `sequence_catalog_category`
# `sequence_product_bundle_option`,
# `sequence_product_bundle_selection`,
# `sequence_product`,
# `sequence_cms_page`,
# `sequence_cms_block`,
# `sequence_salesrule`,
# `sequence_catalogrule`
