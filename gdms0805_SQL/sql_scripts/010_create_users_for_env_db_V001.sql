/* Super user for the env_db database */

CREATE ROLE env_master WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';

COMMENT ON ROLE env_master IS 'Superuser of the env_db database.';

/* Standard user for the env_db database */

CREATE ROLE env_user WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';
	
COMMENT ON ROLE env_user IS 'Standard user of the env_db database.';

