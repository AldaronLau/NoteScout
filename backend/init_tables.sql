-- Use this script to initialize tables within the database.

ON ERROR STOP;
BEGIN;

CREATE TABLE users(
    username TEXT PRIMARY KEY,
    password TEXT,
    pswdsalt TEXT,
    emailadr TEXT
);
-- ALTER TABLE users ADD COLUMN password TEXT;
-- ALTER TABLE users ADD COLUMN pswdsalt INT8;
-- ALTER TABLE users ADD COLUMN emailadr TEXT;

CREATE TABLE notes (
    filename TEXT PRIMARY KEY,
    username TEXT REFERENCES users
    contents TEXT,
    graphics BYTEA,
);
-- ALTER TABLE notes ADD COLUMN username TEXT;
-- ALTER TABLE notes ADD CONSTRAINT users FOREIGN KEY (username) REFERENCES users(username);
-- ALTER TABLE notes ADD COLUMN contents TEXT;
-- ALTER TABLE notes ADD COLUMN graphics BYTEA;

COMMIT;
