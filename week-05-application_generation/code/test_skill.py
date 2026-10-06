# Verify the skill's own claims: referenced files exist, documented
# queries (the CSV patterns in skills/what-it-does.md) run unmodified.
import csv
import pathlib

missing = [
    str(p) for p in (
        pathlib.Path("artifacts/chinese_emperors_dynasties_trad.csv"),
        pathlib.Path("artifacts/chinese_emperors_rulers_trad.csv"),
        pathlib.Path("artifacts/chinese_emperors_era_names_trad.csv"),
        pathlib.Path("skills/what-it-does.md"),
        pathlib.Path("skills/how-to-maintain.md"),
        pathlib.Path("skills/principles.md"),
        pathlib.Path("research/design/design_doc.md"),
    ) if not p.exists()
]
print("missing files:", missing or "none")


def load(name):
    with open(f"artifacts/chinese_emperors_{name}_trad.csv",
              encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


dyn, rul, era = load("dynasties"), load("rulers"), load("era_names")
print(f"loaded: {len(dyn)} dynasties, {len(rul)} rulers, {len(era)} eras")

# find a ruler
found = [r for r in rul if r["personal_name_cn"] == "嬴政"]
print("find 嬴政:", [(r["id"], r["posthumous_name"]) for r in found])

# successor by predecessor chain
succ = [r for r in rul if r["predecessor_id"] == "1"]
print("successor of id 1:", [(r["id"], r["personal_name_cn"]) for r in succ])

# full line of a dynasty
ming_id = [d["id"] for d in dyn if d["name_cn"] == "明"][0]
print("Ming rulers:", len([r for r in rul if r["dynasty_id"] == ming_id]))

# who ruled in 1127
print("year 1127:", [(r["id"], r["personal_name_cn"]) for r in rul
                     if int(r["year_start"]) <= 1127 <= int(r["year_end"])])

# eras of a ruler
print("eras of 265:", [e["name_cn"] for e in era if e["ruler_id"] == "265"])

# longest reigns
top = sorted(rul, key=lambda r: int(r["year_end"]) - int(r["year_start"]), reverse=True)[0]
print("longest reign:", top["personal_name_cn"][:12],
      int(top["year_end"]) - int(top["year_start"]), "years")

# traditional characters present (spot check a known traditional form)
wanli = [e for e in era if e["id"] == "21"][0]["name_cn"]
print("era 21 characters:", wanli, "(expect 萬曆)")
