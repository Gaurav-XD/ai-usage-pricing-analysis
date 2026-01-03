-- Disable foreign key checks to allow clean reset
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE ai_usage;
TRUNCATE TABLE discounts;
TRUNCATE TABLE subscriptions;
TRUNCATE TABLE customers;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
