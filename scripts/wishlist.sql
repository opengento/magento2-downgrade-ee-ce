ALTER TABLE `wishlist`
    DROP INDEX WISHLIST_CUSTOMER_ID,
    ADD CONSTRAINT `WISHLIST_CUSTOMER_ID` UNIQUE KEY (`customer_id`);
