BEGIN;

SELECT _v.register_patch( '20110302-initial' );

CREATE TABLE account (
    user_id TEXT PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    password TEXT
);

COMMIT;
