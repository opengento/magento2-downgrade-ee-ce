# Migration Tool for Magento Commerce to Magento OpenSource

> Also known as Magento Enterprise (EE) to Magento Community (CE).

This migrating tool allows to downgrade the database schema without altering the data. The major difference between the
two editions are the `staging` definitions that enable draft and scheduled publication. Beside that the scripts provided
by the tool will remove some specific tables and attributes of the Magento Commerce Edition.

Be aware since Magento `>=2.3` the declarative schema has been introduces. It means that this tool is not mandatory to
migrate from EE to CE if you have a ***fresh install of a Magento `>=2.3`***.
However the usage of this tool is advised.

**NOTICE**
- This tool has been test with a Magento Commerce 2.2.* version.
- This tool has not been tested with a split database configuration.

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
