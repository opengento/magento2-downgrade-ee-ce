--
-- 11_sales.sql
-- 

# These columns are add by these three EE modules: Magento_CustomerBalance, Magento_GiftCardAccount and Magento_GiftRegistry
ALTER TABLE `sales_order`
    DROP COLUMN `base_customer_balance_amount`,
    DROP COLUMN `customer_balance_amount`,
    DROP COLUMN `base_customer_balance_invoiced`,
    DROP COLUMN `customer_balance_invoiced`,
    DROP COLUMN `base_customer_balance_refunded`,
    DROP COLUMN `customer_balance_refunded`,
    DROP COLUMN `customer_bal_total_refunded`,
    DROP COLUMN `bs_customer_bal_total_refunded`,

    DROP COLUMN `gift_cards`,
    DROP COLUMN `base_gift_cards_amount`,
    DROP COLUMN `gift_cards_amount`,
    DROP COLUMN `base_gift_cards_invoiced`,
    DROP COLUMN `gift_cards_invoiced`,
    DROP COLUMN `base_gift_cards_refunded`,
    DROP COLUMN `gift_cards_refunded`,

    DROP COLUMN `reward_points_balance`,
    DROP COLUMN `base_reward_currency_amount`,
    DROP COLUMN `reward_currency_amount`,
    DROP COLUMN `base_rwrd_crrncy_amt_invoiced`,
    DROP COLUMN `rwrd_currency_amount_invoiced`,
    DROP COLUMN `base_rwrd_crrncy_amnt_refnded`,
    DROP COLUMN `rwrd_crrncy_amnt_refunded`,
    DROP COLUMN `reward_points_balance_refund`;

ALTER TABLE `sales_order_item`
    DROP COLUMN `giftregistry_item_id`,
    DROP COLUMN `event_id`,
    DROP COLUMN `qty_returned`;

ALTER TABLE `sales_order_address`
    DROP COLUMN `giftregistry_item_id`;

ALTER TABLE `sales_invoice`
    DROP COLUMN `base_customer_balance_amount`,
    DROP COLUMN `customer_balance_amount`,

    DROP COLUMN `base_gift_cards_amount`,
    DROP COLUMN `gift_cards_amount`,

    DROP COLUMN `base_reward_currency_amount`,
    DROP COLUMN `reward_currency_amount`,
    DROP COLUMN `reward_points_balance`;

ALTER TABLE `sales_creditmemo`
    DROP COLUMN `base_customer_balance_amount`,
    DROP COLUMN `customer_balance_amount`,
    DROP COLUMN `bs_customer_bal_total_refunded`,
    DROP COLUMN `customer_bal_total_refunded`,

    DROP COLUMN `base_gift_cards_amount`,
    DROP COLUMN `gift_cards_amount`,

    DROP COLUMN `base_reward_currency_amount`,
    DROP COLUMN `reward_currency_amount`,
    DROP COLUMN `reward_points_balance`,
    DROP COLUMN `reward_points_balance_refund`;

ALTER TABLE `sales_order_grid`
    DROP COLUMN `refunded_to_store_credit`;
