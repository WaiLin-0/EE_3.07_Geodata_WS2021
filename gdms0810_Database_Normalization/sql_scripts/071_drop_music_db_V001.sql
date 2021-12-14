SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'music_db'
AND pid <> pg_backend_pid();

DROP DATABASE music_db;
DROP ROLE music_master;
DROP ROLE music_user;
