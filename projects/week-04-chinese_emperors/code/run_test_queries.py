# Run the exact queries behind each test question's answer (test-questions.md).
import sqlite3

con = sqlite3.connect("artifacts/chinese_emperors.db")
qs = (
    ("Q11 wanli row", "SELECT id, personal_name_cn, year_start, year_end, dynasty_id, source FROM rulers WHERE id = 265"),
    ("Q11 wanli eras", "SELECT id, name_cn, year_start, year_end FROM era_names WHERE ruler_id = 265"),
    ("Q11 wanli successor", "SELECT id, personal_name_cn FROM rulers WHERE predecessor_id = 265"),
    ("Q11 wanli predecessor", "SELECT id, personal_name_cn FROM rulers WHERE id = 264"),
    ("Q12 year 1127", "SELECT r.id, r.personal_name_cn, d.name_cn FROM rulers r JOIN dynasties d ON d.id = r.dynasty_id WHERE r.year_start <= 1127 AND r.year_end >= 1127"),
    ("Q9 three liu yu", "SELECT id, personal_name_cn, posthumous_name, dynasty_id FROM rulers WHERE personal_name = 'Liu Yu'"),
    ("Q9 two xuanzong", "SELECT id, personal_name_cn, dynasty_id, year_start, year_end FROM rulers WHERE temple_name LIKE 'Xuanzong%'"),
    ("Q13 aguda", "SELECT id, posthumous_name, note FROM rulers WHERE id = 232"),
    ("Q10 count", "SELECT COUNT(*) FROM rulers"),
    ("Q5 ming last", "SELECT id, personal_name_cn, year_start, year_end, note FROM rulers WHERE dynasty_id = 43 ORDER BY year_end DESC LIMIT 1"),
    ("Q6 hong taiji era", "SELECT id, name_cn, year_start, year_end, ruler_id FROM era_names WHERE ruler_id = 270"),
    ("Q8 no year zero", "SELECT id, personal_name_cn, year_start, year_end FROM rulers WHERE year_start <= 1 AND year_end >= 1"),
    ("Q7 xuanwu note", "SELECT id, note FROM rulers WHERE id = 120"),
)
for label, q in qs:
    print(label, "->", con.execute(q).fetchall())
