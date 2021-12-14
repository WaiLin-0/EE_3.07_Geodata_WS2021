
/* Terminate all open connections to the DB. Otherwise the DB is still in use and cannot be dropped. */
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'music_db'
AND pid <> pg_backend_pid();

/* 
Drop DB first and then the users. 
When you try to drop the users first an error is raised because the music_db belongs to the user music_master.
*/
DROP DATABASE music_db;
DROP ROLE music_master;
DROP ROLE music_user;

/* Create "master" login user */

CREATE ROLE music_master WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';
	
COMMENT ON ROLE music_master IS 'Superuser of the music_db database.';

/* Create "normal" login user */

CREATE ROLE music_user WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';
	
COMMENT ON ROLE music_user IS 'Standard user of the music_db database.';


/* 
Create database music_db to store album, tracks and interpreter information.
The schema is similar to the example from the presentation on DB normalization.
*/ 

CREATE DATABASE music_db
    WITH 
    OWNER = music_master
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE music_db IS 'Music database.';


/* 
Connect to the music database as music_user with limited rights to create all tables. 
The tables belong to this user. 
*/ 

\set conn_string "host=localhost dbname=music_db user=music_user password=xxxxxx"
\c :conn_string

/* \echo :conn_string */


/* 
########################
TABLE interpreter
######################## 
*/
CREATE TABLE interpreter 
(
    name varchar(50),
    year numeric(4) NOT NULL,
	CONSTRAINT pk_interpreter PRIMARY KEY (name)
)
WITHOUT OIDS;

COMMENT ON CONSTRAINT pk_interpreter ON interpreter IS 'Primary key of interpreter table';

/*
ALTER TABLE interpreter
    ADD CONSTRAINT pk_interpreter PRIMARY KEY (name);

COMMENT ON CONSTRAINT pk_interpreter ON public.interpreter
    IS 'Primary key of interpreter table';
*/

INSERT INTO interpreter VALUES ('Anastasia', 1999);
INSERT INTO interpreter VALUES ('Pink Floyd', 1964);

/* 
##################
TABLE album
################## 
*/
CREATE TABLE album 
(
    album_id numeric(4),
    title varchar(50) NOT NULL,
	interpreter varchar(50),
	CONSTRAINT pk_album PRIMARY KEY (album_id),
	CONSTRAINT fk_album_interpreter FOREIGN KEY (interpreter) REFERENCES interpreter(name)
)
WITHOUT OIDS;

COMMENT ON CONSTRAINT pk_album ON album IS 'Primary key of album table';

INSERT INTO album VALUES (4711, 'Not That Kind', 'Anastasia');
INSERT INTO album VALUES (4712, 'Wish You Were Here', 'Pink Floyd');
INSERT INTO album VALUES (4713, 'Freak of Nature', 'Anastasia');

/* 
########################
TABLE track
######################## 
*/
CREATE TABLE track 
(
    album_id numeric(4),
	track_id numeric(2),
    title varchar(50) NOT NULL,
	CONSTRAINT pk_track PRIMARY KEY (album_id, track_id),
	CONSTRAINT fk_track_album FOREIGN KEY (album_id) REFERENCES album(album_id)
)
WITHOUT OIDS;

COMMENT ON CONSTRAINT pk_track ON track IS 'Primary key of track table';
COMMENT ON CONSTRAINT fk_track_album ON track IS 'Key attribute "track_id" references foreign key "album_id"';

INSERT INTO track VALUES (4711, 1, 'Not That Kind');
INSERT INTO track VALUES (4711, 2, 'I''m Outta Love');
INSERT INTO track VALUES (4711, 3, 'Cowboys & Kisses');
INSERT INTO track VALUES (4712, 1, 'Shine On You Crazy Diamond');
INSERT INTO track VALUES (4713, 1, 'Paid My Dues');


/* Combine all information in one view. */
create view music_db_overview as 
select t1.album_id, t1.title, t2.name, t2.year, t3.track_id, t3.title as song
from album as t1, interpreter as t2, track as t3
where t1.album_id = t3.album_id 
and t1.interpreter = t2.name
