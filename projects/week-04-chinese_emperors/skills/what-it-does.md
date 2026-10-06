# What it does — answering a question from the database

The workflow, the data it runs against, then the ready-made recipes.

## The workflow

1. **Load the three exports** (never the SQLite file, never the simplified
   CSVs) with the standard helper, run from the project root:

   ```python
   import csv

   def load(name):
       with open(f"artifacts/chinese_emperors_{name}_trad.csv",
                 encoding="utf-8-sig", newline="") as f:
           return list(csv.DictReader(f))

   dyn = load("dynasties")   # 44 rows
   rul = load("rulers")      # 280 rows
   era = load("era_names")   # 35 rows
   ```

   Empty cell = empty string; every value is a string — cast years with
   `int()` before arithmetic.
2. **Find the rows** that answer the question (patterns below).
3. **Compose the answer under `skills/principles.md`**: every factual claim
   carries `[id]` and the row's `source`; names in the data's own
   characters; rival states overlap, so "who was emperor in year X" can
   have several true answers — give them all, by state; a `note` that
   doubts itself is quoted as-is, not rounded away; when asked "how
   many", state the counting rule before the number.
4. **Check yourself against the rubric** in `skills/principles.md`: a
   reader should be able to strike every sentence and find its row. If
   not, the answer is not ready.

## The usual patterns

Find a ruler, by characters or romanisation:

```python
[r for r in rul if r["personal_name_cn"] == "嬴政"]
[r for r in rul if "Zheng" in r["personal_name"]]
```

Who followed emperor X (successor by predecessor chain):

```python
[r for r in rul if r["predecessor_id"] == "1"]   # 1 = Qin Shi Huang
```

The full line of a dynasty:

```python
ming_id = [d["id"] for d in dyn if d["name_cn"] == "明"][0]
[r for r in rul if r["dynasty_id"] == ming_id]
```

Who ruled in year Y (rival states overlap on purpose):

```python
[r["personal_name_cn"] + "（" + dyn_by_id[r["dynasty_id"]]["name_cn"] + "）"
 for r in rul if int(r["year_start"]) <= 1127 <= int(r["year_end"])]
```

All era names of a ruler:

```python
[e["name_cn"] for e in era if e["ruler_id"] == "265"]   # 265 = 朱翊钧 Wanli
```

Longest / shortest reigns:

```python
sorted(rul, key=lambda r: int(r["year_end"]) - int(r["year_start"]), reverse=True)[:5]
```

Corner cases (the quiz material):

```python
[r for r in rul if "deposed" in r["posthumous_name"] or "to verify" in r["posthumous_name"]]
```

## What the data holds

### dynasties (44 rows)

| Column | Holds | Notes |
|---|---|---|
| id | 1-44 | load order = chronological |
| name / name_cn | romanised / original | e.g. Qin / 秦 |
| year_start / year_end | state lifespan | negative = BCE |
| capital | seat(s) of power | several states moved capitals |
| source | the state's standard history | cited by juan |
| note | founding context, quirks | e.g. Wu Zhou 武周 = Wu Zetian's state |

### rulers (280 rows)

| Column | Holds | Notes |
|---|---|---|
| id | 1-280 | roughly chronological |
| personal_name / personal_name_cn | romanised / original characters | original wording kept beside the normalised form (traditional characters) |
| temple_name | 庙号 | e.g. Taizong 太宗; empty when the state gave none |
| posthumous_name | 谥号 / imperial title | e.g. Wendi 文皇帝; "(to verify)" flags rows not yet checked against the cited juan |
| year_start / year_end | reign years | one row may span TWO reigns (restorations — see note) |
| dynasty_id | key → dynasties | |
| predecessor_id | key → rulers | previous sovereign in the state's claim line; crosses dynasties at abdication coups (23 such links, by design) |
| source / note | citation + doubts | note carries depositions, murders, co-reigns |

Special rows (never count them as ordinary emperors): 子嬰 Ziying (king, not
huangdi), 孺子嬰 Ruzi Ying (crown prince under a regent), 劉賀 Liu He
(27 days), 劉劭 Liu Shao (patricide, name struck), 元釗 Yuan Zhao (infant
puppet), 天順帝 Tianshundi (erased by the victors)… the `note` tells you
which.

### era_names (35 rows)

| Column | Holds | Notes |
|---|---|---|
| id | 1-35 | |
| name / name_cn | romanised / original | e.g. Zhenguan / 貞觀 |
| year_start / year_end | era span | empty year_end = to reign end |
| ruler_id | key → rulers | one ruler can have many eras; Ming/Qing emperors have one — the reign name *is* how they are called |
| source / note | citation + doubts | |

Coverage is **complete for Ming and Qing**, selected icons only for Han,
Tang, Song — say so if asked for an era the table does not have.

## Live numbers

Row counts and other live numbers: run `python code/build_db.py` (prints
them) or just count the CSV rows — they must always agree; if they do not,
something is broken. Do not trust remembered counts.
