# Project Design Document

## Project Title

- Chinese Emperors Database (中国帝王数据库) — every ruler from Qin Shi Huang
  (221 BCE) to the fall of the Qing (1912 CE), with citations.

## Project Files

- [Research Journal](../journal/research_journal.md)
- [Database schema](../../../code/schema.sql)
- [Built database](../../../artifacts/chinese_emperors.db) (git-ignored)

## Background and Context

- Week 4 of DHG508: turn last week's small database into a real relational
  database, and the skill into a progressive one.
- The database must answer questions like: who reigned after emperor X, what
  era names did emperor Y use, which rulers were contemporaries, with a
  `source` on every row.

## Research Questions

- How many rulers held sovereign power in China between 221 BCE and 1912 CE?
- Which of them used the title *huangdi* 皇帝, and when did the title begin?
- How do succession, era names, and dynastic change relate to each other?

## Scope

- Time range: 221 BCE (Qin unification) to 12 February 1912 (Puyi's
  abdication). Rulers before 221 BCE (Shang, Zhou kings) are out of scope.
- All states claiming sovereignty in this range, including rival states of the
  divided periods (Three Kingdoms, Northern & Southern, Five & Ten Kingdoms,
  Liao/Jin/Xi Xia).

## Counting rules (decisions to keep consistent)

1. **Who counts as a ruler:** anyone who held supreme sovereign title
   (huangdi 皇帝) or the state's own supreme title (e.g. king 王 for Ziying and
   most Ten Kingdoms rulers). The exact title goes in `posthumous_name`/`note`.
2. **Included:** deposed and short-reign rulers (e.g. Liu He, 27 days), boy
   emperors, Wu Zetian (the only ruling female, her own state Wu Zhou 690–705),
   rulers of rival states.
3. **Excluded:** regents who never took the title (Empress Lü, Dorgon, Cixi),
   crown princes who predeceased, Manchu khans before 1636 naming (Nurhaci's
   Later Jin noted in `note`).
4. **Predecessor link** (`predecessor_id`) = the previous ruler *in the chain
   of sovereign power for that state's claim line*: within a dynasty it is the
   previous emperor; at a founding by usurpation, abdication or conquest it
   points to the ruler of the fallen state (e.g. Cao Pi → Han Xiandi, Li Yuan
   → Yang Tong, Zhao Kuangyin → Chai Zongxun), so the "abdication coup" chain
   runs continuously. Founders who claimed the throne without taking it from
   a predecessor state (Liu Bei, Sun Quan, Abaoji, Kublai, Nurhaci, Wang Jian,
   Ma Yin, the Southern founders) have NULL. 21 such cross-dynasty links
   exist by design and show up in any "same dynasty" check.
5. Estimated total: **roughly 270–290 rulers** across ~44 states — above the
   200-row requirement even before era names.

## Date convention

- Years are integers; **negative = BCE** (e.g. -221 = 221 BCE).
- There is **no year 0**: -1 is 1 BCE, then 1 CE. Sorting stays correct.
- Year values are approximate where accession dates are disputed; the doubt
  goes in `note`, never silently.

## Methodology

1. `code/schema.sql` — tables, keys, indexes. Rebuildable, never edited by
   hand after creation.
2. `code/seed_*.sql` — one file per batch (per dynasty), run in filename
   order. Adding new material = adding a new seed file and re-running
   `code/build_db.py`. Old rows are never edited.
3. `code/build_db.py` — rebuilds `artifacts/chinese_emperors.db` from scratch
   with `PRAGMA foreign_keys = ON`, prints row counts.
4. Every row carries `source` (document + juan/page) and `note` for anything
   uncertain.
5. Spot-check: 20 random rows compared against the cited originals
   (see `research/journal/`).

## Sources

- Standard dynastic histories (二十四史) via ctext.org, cited by juan 卷, e.g.
  `Shiji 史记, juan 6 秦始皇本纪 (ctext.org)`.
- Qing: *Qingshi gao* 清史稿.
- Full citation list to be kept in `research/references/`.

## Schema (3 tables, 3 foreign keys)

```text
dynasties (id, name, name_cn, year_start, year_end, capital, source, note)
rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name,
        year_start, year_end, dynasty_id →dynasties, predecessor_id →rulers,
        source, note)
era_names (id, name, name_cn, year_start, year_end, ruler_id →rulers,
           source, note)
```

- FK 1: `rulers.dynasty_id → dynasties.id`
- FK 2: `rulers.predecessor_id → rulers.id` (self-reference)
- FK 3: `era_names.ruler_id → rulers.id`
- Original Chinese wording is kept beside the romanised name in every
  `*_cn` column; romanisation is the normalisation, the Chinese is the record.

## Expected Outputs

- `artifacts/chinese_emperors.db` (SQLite, foreign keys on)
- A progressive skill (`SKILL.md` + reference files) that answers questions
  and cites `[id]` + source.
- Rubric and 10+ test questions (Week 4 challenge 4).

## Working Hypotheses

- Ruler counts depend entirely on counting rules; the rules above will be
  defended in the demo.

## Risks and Open Questions

- Divided-period chronologies are disputed (regnal vs. formal accession
  years) — resolved per-row in `note`.
- Ten Kingdoms rulers are mostly *kings*, not emperors — included by rule 1
  and flagged in `note`.
- Yuan and Qing pre-conquest rulers (Genghis Khan, Nurhaci) — included from
  the state's founding, flagged in `note`.

## Action Items

- [x] Copy template, write design doc
- [x] Write schema, seed dynasties + Qin + Western Han
- [x] Eastern Han → Qing, batch by batch (280 rulers, 44 states, 35 eras)
- [x] Spot-check 20 rows, log errors and fixes
- [x] Write skill, rubric, test questions, improvement log
- [ ] Re-run the test sheet cold through the live agent in the demo
- [ ] Read the "(to verify)" rows against the cited juans on ctext.org
