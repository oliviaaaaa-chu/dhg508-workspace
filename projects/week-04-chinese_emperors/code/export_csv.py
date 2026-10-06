import csv
import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")
tables = ("dynasties", "rulers", "era_names")

for table in tables:
    cur = con.execute(f"SELECT * FROM {table}")
    columns = [c[0] for c in cur.description]
    path = f"artifacts/chinese_emperors_{table}.csv"
    with open(path, "w", newline="", encoding="utf-8-sig") as f:
        writer = csv.writer(f)
        writer.writerow(columns)
        writer.writerows(cur)
    print(path, "-", cur.rowcount, "rows exported")

con.close()
