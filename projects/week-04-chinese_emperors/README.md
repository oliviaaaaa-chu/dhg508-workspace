# Chinese Emperors Database (中国帝王数据库)

Every ruler of China from Qin Shi Huang (221 BCE) to the abdication of Puyi
(1912 CE), with a `source` and `note` on every row.

- **44 states/dynasties, 280 rulers, 35 era names** — 359 rows.
- Schema: 3 tables (`dynasties`, `rulers`, `era_names`), 3 foreign keys
  (`rulers.dynasty_id`, self-referencing `rulers.predecessor_id`,
  `era_names.ruler_id`).
- Counting rules and the date convention (negative = BCE, no year 0) are in
  [`research/design/design_doc.md`](research/design/design_doc.md) — read them
  before querying; several rows (Ziying, Liu He, Ruzi Ying, Tianshundi…) are
  deliberate corner cases.

## Build and rebuild

```bash
python code/build_db.py
```

- Rebuilds `artifacts/chinese_emperors.db` from scratch with
  `PRAGMA foreign_keys = ON`.
- To add material: write a new `code/seed_*.sql` (filename order = load
  order), rerun the script. Never edit an old seed file; log the change in
  `research/journal/research_journal.md`.
- Seeds marked "to verify" carry genuine uncertainties in their `note`
  columns — they are part of the 20-row spot-check for the demo.

## Queries that should just work

- Who followed emperor X? (`predecessor_id` chain, across dynasties too)
- Which rulers were contemporaries in a given year? (rival states overlap)
- Which emperors used which era names? (`era_names` per ruler)
- Who was deposed, and how? (`note` fields)

## Sources

Standard dynastic histories (二十四史) via ctext.org, cited by juan per row;
Qing rows cite the *Qingshi gao* 清史稿. Rows marked "to verify" must be
checked against the cited juan before the Week 4 demo.

## Week 4 deliverables in this project

- `SKILL.md` — the short index — plus `skills/` with one job per file:
  `what-it-does.md` (answering), `how-to-maintain.md` (adding material),
  `principles.md` (the rules that always hold)
- `research/notes/rubric.md` — the scoring standard
- `research/notes/test-questions.md` — 12 scored test questions
- `improvement-log.md` — every error, its cause, and the fix
- `research/notes/spot-check-20-log.md` — the 20-row check
