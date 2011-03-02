BEGIN;

SELECT _v.register_patch( '20110302-initial' );

CREATE TABLE account (
    user_id TEXT PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    password TEXT
);

CREATE TABLE bookmark (
    user_id TEXT NOT NULL REFERENCES account,
    uri TEXT NOT NULL,
    uri_hash TEXT NOT NULL,
    short_desc TEXT,
    long_desc TEXT,
    added TIMESTAMP WITH TIME ZONE,
    public BOOLEAN
);

ROLLBACK;
