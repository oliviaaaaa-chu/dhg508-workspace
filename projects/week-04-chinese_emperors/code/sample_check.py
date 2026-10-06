# Pick 20 random rows (fixed seed = reproducible) and export them as the
# spot-check worksheet for Week 4 challenge 2.
# Output: research/notes/spot-check-20-sample.csv

import csv
import random
import sqlite3

SEED = 20260929  # the date the check was run — same seed, same sample

con = sqlite3.connect("artifacts/chinese_emperors.db")
sample = []
plan = (("dynasties", 4), ("rulers", 14), ("era_names", 2))

for table, n in plan:
    rows = con.execute(f"SELECT id FROM {table}").fetchall()
    ids = [r[0] for r in random.Random(SEED).sample(rows, n)]
    for row_id in ids:
        cols = {
            "dynasties": "id, name, name_cn, year_start, year_end, capital, source, note",
            "rulers": "id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note",
            "era_names": "id, name, name_cn, year_start, year_end, ruler_id, source, note",
        }[table]
        row = con.execute(f"SELECT '{table}' AS tbl, {cols} FROM {table} WHERE id = ?", (row_id,)).fetchone()
        sample.append(row)

with open("research/notes/spot-check-20-sample.csv", "w", encoding="utf-8-sig", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["table", "id"] + [
        c for c in ("name", "name_cn", "year_start", "year_end", "capital", "source", "note",
                    "personal_name", "personal_name_cn", "temple_name", "posthumous_name",
                    "dynasty_id", "predecessor_id", "ruler_id") if c in sample[0] or True
    ][: len(sample[0]) - 2])
    writer.writerows(sample)

print(f"seed {SEED} — 20 rows written to research/notes/spot-check-20-sample.csv")
for s in sample:
    print(f"  {s[0]:9s} id={s[1]:3d}  {str(s[2:6])[:80]}")
