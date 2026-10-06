# Convert the three CSV exports to Traditional Chinese (new *_trad.csv files;
# the simplified originals are kept untouched).
# Rerun after export_csv.py to regenerate.

import csv
from opencc import OpenCC

cc = OpenCC("s2t")  # simplified -> traditional
tables = ("dynasties", "rulers", "era_names")


def to_trad(value: str) -> str:
    if not value:
        return value
    # OpenCC s2t emits the variant 啓; the standard traditional form is 啟
    return cc.convert(value).replace("啓", "啟")


for table in tables:
    src = f"artifacts/chinese_emperors_{table}.csv"
    dst = f"artifacts/chinese_emperors_{table}_trad.csv"
    with open(src, encoding="utf-8-sig", newline="") as f:
        rows = list(csv.reader(f))
    converted = [[to_trad(cell) for cell in row] for row in rows]
    with open(dst, "w", encoding="utf-8-sig", newline="") as f:
        csv.writer(f).writerows(converted)
    print(dst, "-", len(converted) - 1, "rows converted")
