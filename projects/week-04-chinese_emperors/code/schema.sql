-- Chinese Emperors Database — schema
-- 3 tables, 3 foreign keys. Rebuilt from scratch by code/build_db.py.
-- Years: integers, negative = BCE (no year 0; -1 = 1 BCE, 1 = 1 CE).

PRAGMA foreign_keys = ON;

CREATE TABLE dynasties (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL UNIQUE,  -- romanised name, e.g. 'Qin'
    name_cn     TEXT    NOT NULL,         -- original, e.g. '秦'
    year_start  INTEGER NOT NULL,
    year_end    INTEGER NOT NULL,
    capital     TEXT,                     -- e.g. 'Xianyang 咸阳'
    source      TEXT    NOT NULL,         -- document + juan/page
    note        TEXT
);

CREATE TABLE rulers (
    id                INTEGER PRIMARY KEY,
    personal_name     TEXT    NOT NULL, -- romanised, e.g. 'Ying Zheng'
    personal_name_cn  TEXT    NOT NULL, -- original, e.g. '嬴政'
    temple_name       TEXT,             -- 庙号, e.g. 'Taizong 太宗'; NULL if none
    posthumous_name   TEXT,             -- 谥号 / imperial title
    year_start        INTEGER NOT NULL,
    year_end          INTEGER NOT NULL,
    dynasty_id        INTEGER NOT NULL REFERENCES dynasties(id),
    predecessor_id    INTEGER REFERENCES rulers(id),
    source            TEXT    NOT NULL, -- document + juan/page
    note              TEXT
);

CREATE TABLE era_names (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,         -- romanised, e.g. 'Jianyuan'
    name_cn     TEXT    NOT NULL,         -- original, e.g. '建元'
    year_start  INTEGER NOT NULL,
    year_end    INTEGER,                  -- NULL = still in use at reign end
    ruler_id    INTEGER NOT NULL REFERENCES rulers(id),
    source      TEXT    NOT NULL,
    note        TEXT
);

CREATE INDEX idx_rulers_dynasty ON rulers(dynasty_id);
CREATE INDEX idx_rulers_predecessor ON rulers(predecessor_id);
CREATE INDEX idx_era_names_ruler ON era_names(ruler_id);
