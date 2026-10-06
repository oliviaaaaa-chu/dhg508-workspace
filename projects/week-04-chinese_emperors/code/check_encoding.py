import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")
bad = 0
columns = (
    ("dynasties", ("name", "name_cn", "capital", "source", "note")),
    ("rulers", ("personal_name", "personal_name_cn", "temple_name", "posthumous_name", "source", "note")),
    ("era_names", ("name", "name_cn", "source", "note")),
)
for table, cols in columns:
    for col in cols:
        n = con.execute(
            f"SELECT COUNT(*) FROM {table} WHERE {col} LIKE '%è%' OR {col} LIKE '%å%' OR {col} LIKE '%ç%'"
        ).fetchone()[0]
        if n:
            print("MOJIBAKE in", table, col, n)
            bad += n
print("Mojibake cells:", bad)
cross = con.execute(
    "SELECT COUNT(*) FROM rulers r JOIN rulers p ON p.id = r.predecessor_id WHERE p.dynasty_id != r.dynasty_id"
).fetchone()[0]
print("Cross-dynasty predecessor links:", cross)
total = con.execute(
    "SELECT (SELECT COUNT(*) FROM dynasties) + (SELECT COUNT(*) FROM rulers) + (SELECT COUNT(*) FROM era_names)"
).fetchone()[0]
print("Total rows:", total)
