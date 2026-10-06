import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")
cur = con.cursor()
cur.execute("SELECT name FROM sqlite_master WHERE type='table'")
print("tables:", [r[0] for r in cur.fetchall()])
for t in ("dynasties", "rulers", "era_names"):
    cur.execute(f"SELECT COUNT(*) FROM {t}")
    print(t, cur.fetchone()[0])
con.close()
