/* Environmental database */

CREATE DATABASE env_db
    WITH 
    OWNER = env_master
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE env_db IS 'Environmental database.';

