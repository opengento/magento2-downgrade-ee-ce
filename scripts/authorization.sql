# These columns are add by the EE module Magento_AdminGws
ALTER TABLE `authorization_role`
    DROP COLUMN `gws_is_all`,
    DROP COLUMN `gws_websites`,
    DROP COLUMN `gws_store_groups`;
