-- Remove EE attributes

DELETE
FROM `eav_attribute`
WHERE `attribute_code` IN ('giftcard_type', 'giftcard_amounts', 'allow_open_amount');
