-- Remove EE attributes

DELETE
FROM `eav_attribute`
WHERE `attribute_code` IN ('giftcard_type','giftcard_amounts','allow_open_amount','related_tgtr_position_limit', 'related_tgtr_position_behavior', 'upsell_tgtr_position_limit', 'upsell_tgtr_position_behavior');
