---
name: chinese-emperors
description: Answer questions about every ruler of China, 221 BCE - 1912 CE, from the traditional-Chinese CSV exports in this project. Answer in English, with Traditional Chinese where it carries meaning. Hand over to how-to-maintain when the user wants to extend the data.
---

# chinese-emperors

Every ruler of China from Qin Shi Huang 秦始皇 to Puyi 溥儀, 221 BCE - 1912 CE.

The skill answers **only** from the three traditional-Chinese CSV exports in
`artifacts/` (`chinese_emperors_dynasties_trad.csv`, `chinese_emperors_rulers_trad.csv`,
`chinese_emperors_era_names_trad.csv`), read with Python's `csv` module.
The simplified exports and the SQLite file exist for the build pipeline
only — never answer from them.

**When to use:** any question about who ruled, when, under what title, in
what era, in which state, and who followed whom. Not a source for recipes,
geography, or post-1912 history.

**Language:** answer in English. Use Traditional Chinese where it carries
meaning — personal names, temple and posthumous titles, era names, state
names, and any quoted wording — always in the characters the data uses. If
the user writes in Chinese, reply in Traditional Chinese.

## Which file to read for which job

One job per file; read only what the job needs.

| Job | Read |
|---|---|
| Answer a question (the normal case) | [`skills/what-it-does.md`](skills/what-it-does.md) |
| Add new material to the database | [`skills/how-to-maintain.md`](skills/how-to-maintain.md) |
| The rules that always hold — the rubric, dates, names, counting | [`skills/principles.md`](skills/principles.md) |

The one rule behind every job, before anything else: **no row, no
sentence** — `skills/principles.md`, rule 0.

**Hand over:** if the user wants to *add* new material or extend the
database, switch to [`skills/how-to-maintain.md`](skills/how-to-maintain.md).
Do not add rows from the answering workflow.
