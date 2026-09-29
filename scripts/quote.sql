# These columns are add by these EE modules: Magento_CustomerBalance, Magento_GiftCardAccount, Magento_GiftRegistry, Magento_Reward and Magento_GiftWrapping
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
    DROP COLUMN `reward_currency_amount`,

    DROP COLUMN `gw_id`,
    DROP COLUMN `gw_allow_gift_receipt`,
    DROP COLUMN `gw_add_card`,
    DROP COLUMN `gw_base_price`,
    DROP COLUMN `gw_price`,
    DROP COLUMN `gw_items_base_price`,
    DROP COLUMN `gw_items_price`,
    DROP COLUMN `gw_card_base_price`,
    DROP COLUMN `gw_card_price`,
    DROP COLUMN `gw_base_tax_amount`,
    DROP COLUMN `gw_tax_amount`,
    DROP COLUMN `gw_items_base_tax_amount`,
    DROP COLUMN `gw_items_tax_amount`,
    DROP COLUMN `gw_card_base_tax_amount`,
    DROP COLUMN `gw_card_tax_amount`,
    DROP COLUMN `gw_base_price_incl_tax`,
    DROP COLUMN `gw_price_incl_tax`,
    DROP COLUMN `gw_items_base_price_incl_tax`,
    DROP COLUMN `gw_items_price_incl_tax`,
    DROP COLUMN `gw_card_base_price_incl_tax`,
    DROP COLUMN `gw_card_price_incl_tax`;

ALTER TABLE `quote_item`
    DROP COLUMN `giftregistry_item_id`,
    DROP COLUMN `event_id`,

    DROP COLUMN `gw_id`,
    DROP COLUMN `gw_base_price`,
    DROP COLUMN `gw_price`,
    DROP COLUMN `gw_base_tax_amount`,
    DROP COLUMN `gw_tax_amount`;

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
    DROP COLUMN `reward_currency_amount`,

    DROP COLUMN `gw_id`,
    DROP COLUMN `gw_allow_gift_receipt`,
    DROP COLUMN `gw_add_card`,
    DROP COLUMN `gw_base_price`,
    DROP COLUMN `gw_price`,
    DROP COLUMN `gw_items_base_price`,
    DROP COLUMN `gw_items_price`,
    DROP COLUMN `gw_card_base_price`,
    DROP COLUMN `gw_card_price`,
    DROP COLUMN `gw_base_tax_amount`,
    DROP COLUMN `gw_tax_amount`,
    DROP COLUMN `gw_items_base_tax_amount`,
    DROP COLUMN `gw_items_tax_amount`,
    DROP COLUMN `gw_card_base_tax_amount`,
    DROP COLUMN `gw_card_tax_amount`,
    DROP COLUMN `gw_base_price_incl_tax`,
    DROP COLUMN `gw_price_incl_tax`,
    DROP COLUMN `gw_items_base_price_incl_tax`,
    DROP COLUMN `gw_items_price_incl_tax`,
    DROP COLUMN `gw_card_base_price_incl_tax`,
    DROP COLUMN `gw_card_price_incl_tax`;

ALTER TABLE `quote_address_item`
    DROP COLUMN `gw_id`,
    DROP COLUMN `gw_base_price`,
    DROP COLUMN `gw_price`,
    DROP COLUMN `gw_base_tax_amount`,
    DROP COLUMN `gw_tax_amount`;
