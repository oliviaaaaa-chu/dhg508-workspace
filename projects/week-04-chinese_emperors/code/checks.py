# Week 4 challenge 2 — consistency sweep over every row, in service of the
# 20-row spot-check. Finds objective errors; documented exceptions are
# whitelisted by id (they are deliberate, explained in the notes columns).

import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")

problems = []


def flag(rule, table, row_id, detail):
    problems.append((rule, table, row_id, detail))


# 1. every row must have a source
for table in ("dynasties", "rulers", "era_names"):
    for row in con.execute(f"SELECT id FROM {table} WHERE source IS NULL OR source = ''"):
        flag("missing source", table, row[0], "")

# 2. year_start <= year_end
for table in ("dynasties", "rulers", "era_names"):
    for row in con.execute(f"SELECT id, year_start, year_end FROM {table}"):
        if row[1] > row[2]:
            flag("year_start > year_end", table, row[0], f"{row[1]}..{row[2]}")

# 3. era years must sit inside the ruler's reign
for row in con.execute(
    """SELECT e.id, e.name_cn, e.year_start, e.year_end, r.year_start, r.year_end, r.personal_name_cn
       FROM era_names e JOIN rulers r ON r.id = e.ruler_id"""
):
    if row[2] < row[4] or (row[3] or row[5]) > row[5]:
        flag("era outside reign", "era_names", row[0], f"{row[1]} {row[2]}..{row[3]} vs {row[6]} {row[4]}..{row[5]}")

# 4. ruler reign inside dynasty bounds (documented exceptions below)
DOCUMENTED_DYNASTY_EXCEPT = {18: "Gengshi claimant", 118: "loyalist Sui at Luoyang to 619", 195: "Abaoji khan 907", 242: "Kublai khagan 1260", 269: "Nurhaci Later Jin 1616", 270: "state renamed Qing 1636"}
for row in con.execute(
    """SELECT r.id, r.personal_name_cn, r.year_start, r.year_end, d.year_start, d.year_end, d.name_cn
       FROM rulers r JOIN dynasties d ON d.id = r.dynasty_id"""
):
    if row[2] < row[4] or row[3] > row[5]:
        if row[0] in DOCUMENTED_DYNASTY_EXCEPT:
            print(f"  documented exception: {row[1]} {row[2]}..{row[3]} vs {row[6]} {row[4]}..{row[5]} ({DOCUMENTED_DYNASTY_EXCEPT[row[0]]})")
        else:
            flag("reign outside dynasty", "rulers", row[0], f"{row[1]} {row[2]}..{row[3]} vs {row[6]} {row[4]}..{row[5]}")

# 5. predecessor adjacency: the successor's start must fall inside the
#    predecessor's overall span (±2) — inside, because rows with two reigns
#    (restorations) span the interruption; at the end, for the normal case
PREDECESSOR_GAP_EXCEPT = {6: "two Shaodi claimants -188..-180 omitted (rule 3, noted in row)"}
for row in con.execute(
    """SELECT r.id, r.personal_name_cn, r.year_start, p.personal_name_cn, p.year_start, p.year_end
       FROM rulers r JOIN rulers p ON p.id = r.predecessor_id"""
):
    lo, hi = row[4] - 1, row[5] + 2
    if not (lo <= row[2] <= hi):
        if row[0] in PREDECESSOR_GAP_EXCEPT:
            print(f"  documented exception: {row[1]} starts {row[2]} ({PREDECESSOR_GAP_EXCEPT[row[0]]})")
        else:
            flag("predecessor gap", "rulers", row[0],
                 f"{row[1]} starts {row[2]}, {row[3]} spans {row[4]}..{row[5]}")

cross = con.execute(
    "SELECT COUNT(*) FROM rulers r JOIN rulers p ON p.id = r.predecessor_id WHERE p.dynasty_id != r.dynasty_id"
).fetchone()[0]

print(f"cross-dynasty predecessor links (by design): {cross}")
if problems:
    print(f"\n{len(problems)} PROBLEM(S):")
    for rule, table, row_id, detail in problems:
        print(f"  [{rule}] {table} id={row_id} {detail}")
else:
    print("all consistency checks clean")
