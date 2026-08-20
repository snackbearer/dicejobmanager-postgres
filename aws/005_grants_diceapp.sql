-- Grants for API runtime user (used with IAM auth)
-- Run this as a DB owner/admin against RDS. Do not mount this into local Docker init;
-- GRANT rds_iam will fail on a local Postgres 17 container.

-- Ensure role exists (on RDS this is your DB login role, e.g. diceapp).
-- CREATE ROLE diceapp LOGIN;

GRANT USAGE ON SCHEMA public TO diceapp;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO diceapp;

GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO diceapp;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO diceapp;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO diceapp;

GRANT rds_iam TO diceapp;
