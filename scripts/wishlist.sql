-- Magento_MultipleWishlist allows several wishlists per customer, CE allows only one.
-- Merge the items into the oldest wishlist of each customer, then remove the others.

UPDATE `wishlist_item` i
    INNER JOIN `wishlist` w ON w.`wishlist_id` = i.`wishlist_id`
    INNER JOIN (SELECT `customer_id`, MIN(`wishlist_id`) AS `keep_id` FROM `wishlist` GROUP BY `customer_id`) k
    ON k.`customer_id` = w.`customer_id`
SET i.`wishlist_id` = k.`keep_id`
WHERE i.`wishlist_id` <> k.`keep_id`;

DELETE w
FROM `wishlist` w
         INNER JOIN (SELECT `customer_id`, MIN(`wishlist_id`) AS `keep_id` FROM `wishlist` GROUP BY `customer_id`) k
                    ON k.`customer_id` = w.`customer_id`
WHERE w.`wishlist_id` <> k.`keep_id`;

ALTER TABLE `wishlist`
    DROP COLUMN `name`,
    DROP COLUMN `visibility`,
    DROP INDEX WISHLIST_CUSTOMER_ID,
    ADD CONSTRAINT `WISHLIST_CUSTOMER_ID` UNIQUE KEY (`customer_id`);
