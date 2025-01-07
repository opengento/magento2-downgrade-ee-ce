# Migration Tool for Adobe Commerce to Magento Open Source

> Also known as Adobe Commerce to Magento Open Source
> Also known as Adobe Commerce Cloud to Magento Open Source.
> Also known as Magento Commerce to Magento Open Source.
> Also known as Magento Enterprise (EE) to Magento Community (CE).

This migrating tool allows to downgrade the database schema without altering the data. The major difference between the
two editions are the `staging` definitions that enable draft and scheduled publication. Beside that the scripts provided
by the tool will remove some specific tables and attributes of the Magento Commerce Edition. It will also o my keep the latest version available for product and categories in staging.

**NOTICE**
- This tool has been initially developed for Magento Commerce 2.2.* version.
- This tool has not been tested with a split database configuration.
- Looking #6 it seems that the tool is working also with Magento Commerces 2.4.*

## How to use

`mysql -u <user> <database> < <script.sql>`

> Where :
> - `user` is your mysql user.
> - `password` is your mysql user credentials
> - `database` is your magento database
> - `script.sql` is the script you want to run from the following list:

**READY TO USE:**

- [Attributes](./scripts/attributes.sql)
- [SalesRule](./scripts/salesrule.sql)
- [CatalogRule](./scripts/catalogrule.sql)
- [Category](./scripts/category.sql)
- [Product](./scripts/product.sql)
- [CMS](./scripts/cms.sql)
- [EE Tables](./scripts/ee.sql)

## Similar package

- [https://github.com/hoangnm89/m2-query-ee-to-ce](https://github.com/hoangnm89/m2-query-ee-to-ce)

## Authors

- **Thomas Klein** - *Maintainer* - [![GitHub followers](https://img.shields.io/github/followers/thomas-kl1.svg?style=social)](https://github.com/thomas-kl1)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) details.

***That's all folks!***
