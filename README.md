Migrating EE to CE resolve in indexer issue if you forget to remove additon done by the statging modules on the database.

Use ee-2-ce.sql to fix the catalog tables.

/!\ This fix only apply for Magento Version < 2.3 /!\

It will works for 2.3 but thanks to declarative schema it should not be an issue anymore.

READY TO USE:

- attributes.sql
- catalogrule.sql

WIP:

- ee.sql
- cms.sql
- product.sql
- category.sql
