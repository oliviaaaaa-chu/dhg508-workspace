# Rebuild artifacts/chinese_emperors.db from scratch.
# Run: python code/build_db.py   (from the project root)
# Adding new material = add a new code/seed_*.sql, then re-run this script.
# Old seed files are never edited; the database is always rebuilt fresh.

import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "artifacts" / "chinese_emperors.db"
TABLES = ("dynasties", "rulers", "era_names")


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    DB.parent.mkdir(parents=True, exist_ok=True)
    if DB.exists():
        DB.unlink()

    con = sqlite3.connect(DB)
    con.execute("PRAGMA foreign_keys = ON")

    for sql_file in sorted((ROOT / "code").glob("*.sql")):
        con.executescript(sql_file.read_text(encoding="utf-8"))
        print(f"applied {sql_file.name}")

    con.commit()

    violations = con.execute("PRAGMA foreign_key_check").fetchall()
    if violations:
        raise SystemExit(f"FOREIGN KEY VIOLATIONS: {violations}")

    print(f"\nbuilt {DB}")
    for table in TABLES:
        n = con.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
        print(f"{table}: {n} rows")

    con.close()


if __name__ == "__main__":
    main()
