import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")
total = sum(con.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0] for t in ("dynasties", "rulers", "era_names"))
print("TOTAL ROWS:", total, "(requirement: 200+)")

print("Wanli era:", con.execute(
    "SELECT e.name_cn, e.year_start, e.year_end FROM era_names e "
    "JOIN rulers r ON r.id = e.ruler_id WHERE r.personal_name_cn = '朱翊钧'"
).fetchone())

print("Who followed Li Zhu (last Tang):", con.execute(
    "SELECT r.personal_name_cn, d.name FROM rulers r "
    "JOIN dynasties d ON d.id = r.dynasty_id WHERE r.predecessor_id = 139"
).fetchall())

print("Three Liu Yu:", con.execute(
    "SELECT id, personal_name_cn, posthumous_name FROM rulers WHERE personal_name = 'Liu Yu'"
).fetchall())

print("Wanli era (Zhu Yijun id 265):", con.execute(
    "SELECT e.name_cn, e.year_start, e.year_end FROM era_names e WHERE e.ruler_id = 265"
).fetchall())

print("Who followed Li Zhu (id 139):", con.execute(
    "SELECT r.id, r.personal_name_cn, d.name FROM rulers r "
    "JOIN dynasties d ON d.id = r.dynasty_id WHERE r.predecessor_id = 139"
).fetchall())

