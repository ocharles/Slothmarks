BEGIN;

SELECT _v.register_patch( '20110303-bookmark' );

CREATE TABLE bookmark (
    uri TEXT NOT NULL,
    hash TEXT PRIMARY KEY
);

CREATE TABLE user_bookmark (
    hash TEXT PRIMARY KEY REFERENCES bookmark,
    short_desc TEXT,
    long_desc TEXT,
    user_id TEXT NOT NULL REFERENCES account
);

COMMIT;
