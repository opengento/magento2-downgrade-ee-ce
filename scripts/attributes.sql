-- Remove EE attributes

-- Attributes of the EE entity types (RMA item, CMS staging)
DELETE a
FROM `eav_attribute` a
         INNER JOIN `eav_entity_type` t ON t.`entity_type_id` = a.`entity_type_id`
WHERE t.`entity_type_code` IN ('rma_item','cms_page','cms_block');

DELETE
FROM `eav_entity_type`
WHERE `entity_type_code` IN ('rma_item','cms_page','cms_block');

-- EE attributes on CE entity types, filtered by entity type so that
-- project attributes sharing the same code are not removed

DELETE a
FROM `eav_attribute` a
         INNER JOIN `eav_entity_type` t ON t.`entity_type_id` = a.`entity_type_id`
WHERE t.`entity_type_code` = 'catalog_product'
  AND a.`attribute_code` IN (
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
                             'use_config_lifetime'
    );

DELETE a
FROM `eav_attribute` a
         INNER JOIN `eav_entity_type` t ON t.`entity_type_id` = a.`entity_type_id`
WHERE t.`entity_type_code` = 'catalog_category'
  AND a.`attribute_code` = 'automatic_sorting';

DELETE a
FROM `eav_attribute` a
         INNER JOIN `eav_entity_type` t ON t.`entity_type_id` = a.`entity_type_id`
WHERE t.`entity_type_code` = 'customer'
  AND a.`attribute_code` IN ('reward_update_notification', 'reward_warning_notification');

-- Magento_Reward codes, specific enough to be removed whatever the entity type
DELETE
FROM `eav_attribute`
WHERE `attribute_code` IN ('reward_points_balance_refunded', 'reward_salesrule_points');
