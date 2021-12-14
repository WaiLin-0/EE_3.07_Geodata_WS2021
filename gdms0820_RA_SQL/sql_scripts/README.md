# Database Setup #

## Prepare the users and the database for environmental monitoring ##

Let us create new users and a new database which we will use for first exercises to get used to SQL and relational algebra (RA). Later we will use the setup to manage environmental data. The environmental database is named env_db and the related users env_master and env_user, respectively.

Open a command line interface (e.g. run "cmd" on Windows or open a terminal under Linux)

Change directory to where the sql scripts are located, usually in a subdirectory of the material you pulled from the Git repo. The scripts have the extension *.sql. 
Read the code of the scripts. Open the scripts your favorite editor.

**Change and remember the passwords** in the SQL script creating the users!

Be sure you know the host your postgres database resides on (e.g. localhost) and the password of user postgres.

To create new database users execute:

	psql -h <host> -U postgres postgres < 010_create_users_for_env_db_V001.sql

The command line option `-U postgres` sets the user to postgres (the DB superuser). The parameter without a parameter flag (such as "-h") denotes the DB name. To create the users we use the _maintenance database_ `postgres`.  

Now let us create the new database `env_db`:

	psql -h <host> -U postgres postgres < 020_create_database_env_db_V001.sql

## First (temporary) the relations used in the presentation on Relational Algebra ##

Now use the new DB user `env_user` to create the tables (relations) in the new database `env_db` used for the first exercises.

Have a look at the SQL script creating the tables for the _bar example_ of the RA presentation.




