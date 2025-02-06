# These columns are add by these three EE modules: Magento_CustomerBalance, Magento_GiftCardAccount and Magento_GiftRegistry
ALTER TABLE `quote`
    DROP COLUMN `customer_balance_amount_used`,
    DROP COLUMN `base_customer_bal_amount_used`,
    DROP COLUMN `use_customer_balance`,

    DROP COLUMN `gift_cards`,
    DROP COLUMN `gift_cards_amount`,
    DROP COLUMN `base_gift_cards_amount`,
    DROP COLUMN `gift_cards_amount_used`,
    DROP COLUMN `base_gift_cards_amount_used`,

    DROP COLUMN `use_reward_points`,
    DROP COLUMN `reward_points_balance`,
    DROP COLUMN `base_reward_currency_amount`,
    DROP COLUMN `reward_currency_amount`;

ALTER TABLE `quote_item`
    DROP COLUMN `giftregistry_item_id`,
    DROP COLUMN `event_id`;

ALTER TABLE `quote_address`
    DROP COLUMN `base_customer_balance_amount`,
    DROP COLUMN `customer_balance_amount`,

    DROP COLUMN `gift_cards_amount`,
    DROP COLUMN `base_gift_cards_amount`,
    DROP COLUMN `gift_cards`,
    DROP COLUMN `used_gift_cards`,
    DROP COLUMN `giftregistry_item_id`,

    DROP COLUMN `reward_points_balance`,
    DROP COLUMN `base_reward_currency_amount`,
    DROP COLUMN `reward_currency_amount`;
