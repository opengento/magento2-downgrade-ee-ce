# Migration Tool for Adobe Commerce to Magento Open Source

> Also known as Adobe Commerce to Magento Open Source
> Also known as Adobe Commerce Cloud to Magento Open Source.
> Also known as Magento Commerce to Magento Open Source.
> Also known as Magento Enterprise (EE) to Magento Community (CE).

This migrating tool allows to sidegrade the database schema without altering the data. The major difference between the
two editions are the `staging` definitions that enable draft and scheduled publication. Beside that the scripts provided
by the tool will remove some specific tables and attributes of the Adobe Commerce Edition. It will also keep the latest version available for product and categories in staging mode.

**NOTICE**
- This tool has been initially developed for Magento Commerce 2.2.* version.
- This tool is working with latest Adobe Commerce 2.4.* (tested with 2.4.7-p3, thanks to this amazing contributor : [@LucaGallinari](https://github.com/LucaGallinari) [![GitHub followers](https://img.shields.io/github/followers/LucaGallinari.svg?style=social)](https://github.com/LucaGallinari) ❤️)

## How to use

`mysql -u <user> <database> < <script.sql>`

> Where :
> - `user` is your mysql user.
> - `password` is your mysql user credentials
> - `database` is your magento database
> - `script.sql` is the script you want to run from the following list:

You can use the following [sample](./downgrade.sample).

**READY TO USE:**

- [Attributes](./scripts/attributes.sql)
- [SalesRule](./scripts/salesrule.sql)
- [CatalogRule](./scripts/catalogrule.sql)
- [Category](./scripts/category.sql)
- [Product](./scripts/product.sql)
- [CMS](./scripts/cms.sql)
- [EE Tables](./scripts/ee.sql)
- [Wishlist](./scripts/wishlist.sql)
- [CatalogInventory](./scripts/cataloginventory.sql)
- [Customer](./scripts/customer.sql)
- [Quote](./scripts/quote.sql)
- [Sales](./scripts/sales.sql)

## Similar package

- [https://github.com/hoangnm89/m2-query-ee-to-ce](https://github.com/hoangnm89/m2-query-ee-to-ce)

## Authors

- **Thomas Klein** - *Maintainer* - [![GitHub followers](https://img.shields.io/github/followers/thomas-kl1.svg?style=social)](https://github.com/thomas-kl1)
- **Contributors** - *Contributor* - [![GitHub contributors](https://img.shields.io/github/contributors/opengento/magento2-downgrade-ee-ce.svg?style=flat-square)](https://github.com/opengento/magento2-downgrade-ee-ce/graphs/contributors)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) details.

***That's all folks!***
